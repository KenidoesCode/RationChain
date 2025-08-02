# 🇮🇳 RationChain – Decentralized Public Distribution System (PDS)

RationChain is a smart contract-based solution that aims to revolutionize the Indian Public Distribution System (PDS) using blockchain technology. It ensures transparent, tamper-proof, and accessible delivery of ration to eligible citizens by minimizing corruption and improving traceability.

---

## 🚀 Features

- ✅ **Aadhaar-based beneficiary verification** (hash-based, privacy-friendly)
- ✅ **State-wise decentralized admin control**
- ✅ **Prevent duplicate registrations**
- ✅ **Quota management for rice and dal**
- ✅ **Claim tracking with time restrictions**
- ✅ **Fully on-chain transparency**

---

## 🧠 Tech Stack

- **Solidity** – Smart contract development  
- **Ethereum / EVM-compatible blockchain**  
- **Remix IDE** – For testing and deployment  
- *(Frontend integration in progress)*

---

## 📂 Contract Highlights

- `addBeneficiary()` – Registers new ration card holders by State Admin
- `claimRation()` – Allows beneficiaries to claim their monthly quota
- `removeStateAdmin()` – Enables central admin to remove rogue State Admins
- `usedAadhaar mapping` – Prevents duplicate Aadhaar registrations
- `time-based restriction` – Prevents early reclaims

---

## 🔐 Security + Ethics Focus

RationChain has been designed with ethical delivery in mind:
- Prevents overriding critical mappings
- Prevents misuse by state admins
- Ensures poorest beneficiaries are not locked out by loopholes

---

## 📦 Deployment

The smart contract can be tested and deployed using:
- [Remix IDE](https://remix.ethereum.org/)
- MetaMask Wallet (for admin/user testing)
- Local or testnet (e.g., Sepolia, Polygon Mumbai)

---

## 📜 License

This project is licensed under the **MIT License** – feel free to use and modify ethically.
