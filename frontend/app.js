let contractAddress = 0xef48eb47752dcd2d7bb8fb2c2889ae11a4ca39df;
let contractABI = [
    // Paste your contract ABI here
];

let web3;
let contract;
let userAccount;

// Connect to MetaMask
async function connectWallet() {
    if (window.ethereum) {
        web3 = new Web3(window.ethereum);
        await window.ethereum.request({ method: "eth_requestAccounts" });
        let accounts = await web3.eth.getAccounts();
        userAccount = accounts[0];
        contract = new web3.eth.Contract(contractABI, contractAddress);
        console.log("Connected to MetaMask:", userAccount);
        fetchSponsors();
    } else {
        alert("Please install MetaMask!");
    }
}

// Add a sponsor
async function addSponsor() {
    let sponsorName = document.getElementById("sponsorName").value;
    let amount = document.getElementById("amount").value;
    if (!sponsorName || amount <= 0) {
        alert("Enter valid sponsor name and amount.");
        return;
    }
    
    let ethAmount = web3.utils.toWei(amount, "ether");

    try {
        await contract.methods.addSponsor(sponsorName).send({
            from: userAccount,
            value: ethAmount
        });
        alert("Sponsor added successfully!");
        fetchSponsors();
    } catch (error) {
        console.error("Error adding sponsor:", error);
    }
}

// Fetch sponsor list
async function fetchSponsors() {
    try {
        let sponsors = await contract.methods.getSponsors().call();
        let sponsorList = document.getElementById("sponsorList");
        sponsorList.innerHTML = "";

        sponsors.forEach((sponsor) => {
            let li = document.createElement("li");
            li.textContent = `${sponsor.name} - ${web3.utils.fromWei(sponsor.amount, "ether")} ETH`;
            sponsorList.appendChild(li);
        });
    } catch (error) {
        console.error("Error fetching sponsors:", error);
    }
}

// Withdraw funds
async function withdrawFunds() {
    try {
        await contract.methods.withdraw().send({ from: userAccount });
        alert("Funds withdrawn successfully!");
    } catch (error) {
        console.error("Error withdrawing funds:", error);
    }
}

// Auto-connect wallet on page load
window.onload = connectWallet;
