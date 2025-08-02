// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RationChain {
    address public admin;

    uint riceInventory;
    uint dalInventory;
    bool paused = false;

    constructor(uint _initialRice, uint _initialDal) {
        admin = msg.sender;
        riceInventory = _initialRice;
        dalInventory = _initialDal;
    }

    struct Beneficiary {
        string name;
        uint riceQuota;
        uint dalQuota;
        uint lastClaimedTime;
        bool isRegistered;
        string state;
        bytes32 aadhaarHash;
    }

    mapping(address => Beneficiary) public beneficiaries;
    mapping(string => address) public stateAdmins;
    mapping(bytes32 => bool) public usedAadhaar;

    function addBeneficiary(
        string memory _name,
        uint _riceQuota,
        uint _dalQuota,
        address _userAddress,
        string memory _state,
        bytes32 _aadhaarHash
    ) public {
        require(msg.sender == admin ||   msg.sender == stateAdmins[_state], "Only admin or State Admin can add beneficiaries");

        require( !beneficiaries[_userAddress].isRegistered,"Already Registered");
            
        require(!usedAadhaar[_aadhaarHash],"Adhaar already used");

        beneficiaries[_userAddress] = Beneficiary({
            name: _name,
            riceQuota: _riceQuota,
            dalQuota: _dalQuota,
            lastClaimedTime: 0,
            isRegistered: true,
            state: _state,
            aadhaarHash:_aadhaarHash
        });
        usedAadhaar[_aadhaarHash]=true;
    }

    function claimedRation() public {
        require(
            beneficiaries[msg.sender].isRegistered == true,
            "Not Registered"
        );

        uint lastTime = beneficiaries[msg.sender].lastClaimedTime;

        uint currentTime = block.timestamp;

        uint ricetogive = 100;

        uint dalToGive = 100;

        ricetogive = beneficiaries[msg.sender].riceQuota;

        require(
            currentTime - lastTime >= 7 * 24 * 60 * 60,
            "Cannot claim ration more than once in a week"
        );

        require(
            riceInventory >= ricetogive,
            "Requested Quantity is more than available"
        );

        riceInventory -= ricetogive;

        dalToGive = beneficiaries[msg.sender].dalQuota;

        require(
            dalInventory >= dalToGive,
            "Requested Quantity is more than available"
        );

        dalInventory -= dalToGive;

        beneficiaries[msg.sender].lastClaimedTime = currentTime;

        emit RationClaimed(msg.sender, ricetogive, dalToGive);
    }
    event RationClaimed(address indexed user, uint rice, uint dal);

    function addStock() public {
        require(msg.sender == admin, "Only admin can perform this action");
        riceInventory += 1000;
        dalInventory += 1500;
    }

    function updateQuota(
        address _user,
        uint _newRiceQuota,
        uint _newDalQuota
    ) public {
        require(msg.sender == admin, "Only admin can perform this action");
        beneficiaries[_user].riceQuota = _newRiceQuota;
        beneficiaries[_user].dalQuota = _newDalQuota;
    }

    function removeBeneficiary(address _user) public {
        require(msg.sender == admin, "Only admin can perform this action");
        delete beneficiaries[_user];
    }

    function getInventory() public view returns (uint, uint) {
        return (riceInventory, dalInventory);
    }

    function getBeneficiaryInfo(
        address user
    ) public view returns (string memory, uint, uint, uint, bool) {
        Beneficiary memory b = beneficiaries[user];
        return (
            b.name,
            b.riceQuota,
            b.dalQuota,
            b.lastClaimedTime,
            b.isRegistered
        );
    }

    function transferAdminRole(address newAdmin) public {
        require(msg.sender == admin, "Only the admin can perform this action");
        require(newAdmin != address(0), "New admin cannot be zero");
        admin = newAdmin;
    }

    function pauseRation() public {
        require(msg.sender == admin, "Only admin can perform this action");
        paused = true;
    }

    function updateContract() public {
        require(msg.sender == admin, "Only admin can perform this action");
        paused = false;
    }

    function addStateAdmin(string memory _state, address _adminAddress) public {
        // only central authority of india have the rights to add state admins
        require(msg.sender == admin, "Only admin can perform this action");
        require(
            stateAdmins[_state] == address(0),
            "State admin already exists"
        ); //to prevent overriding
        stateAdmins[_state] = _adminAddress;
    }

    function removeStateAdmin(string memory _state) public {
        require(msg.sender == admin, "Only admin can perform this action");
        require(
            stateAdmins[_state] != address(0),
            "State admin does not exist"
        );
        stateAdmins[_state] = address(0);
    }
}
