# Sponsor Tracker

A blockchain-based solution for listing and tracking sponsors for events. This smart contract system allows event organizers to efficiently manage sponsor relationships, track contributions, and maintain transparency in sponsorship dealings.

## Table of Contents
- [Project Title](#sponsor-tracker)
- [Project Description](#project-description)
- [Project Vision](#project-vision)
- [Future Scope](#future-scope)
- [Key Features](#key-features)
- [Technical Details](#technical-details)
- [Setup and Deployment](#setup-and-deployment)
- [Usage Guide](#usage-guide)
- [License](#license)

## Project Description

Sponsor Tracker is a decentralized application built on blockchain technology that provides a comprehensive solution for managing event sponsorships. The platform allows event organizers to register sponsors, create events, track contributions, and maintain a transparent record of all sponsorship activities. By leveraging blockchain technology, the system ensures immutability, transparency, and accountability in sponsorship dealings.

## Project Vision

The vision for Sponsor Tracker is to revolutionize how event sponsorships are managed by creating a trustless, transparent, and efficient ecosystem for event organizers and sponsors. We aim to:

1. **Increase Transparency**: Create an immutable record of all sponsorship dealings that is accessible to all relevant parties.
2. **Improve Efficiency**: Streamline the process of managing sponsors and tracking contributions across multiple events.
3. **Build Trust**: Establish a platform that builds trust between event organizers and sponsors through verifiable transactions and agreements.
4. **Promote Accountability**: Ensure all parties fulfill their obligations by maintaining a permanent record of commitments and contributions.
5. **Facilitate Relationships**: Create a system that fosters long-term relationships between organizers and sponsors by providing clear value tracking.

## Future Scope

The Sponsor Tracker project has significant potential for expansion in multiple directions:

1. **Integration with DeFi Protocols**:
   - Enable sponsors to make contributions directly through the platform using various cryptocurrencies
   - Implement time-locked sponsorship funds that are released upon meeting specific milestones
   - Create sponsorship pools for larger events with multiple contributors

2. **Enhanced Analytics**:
   - Develop comprehensive analytics for tracking ROI on sponsorships
   - Implement metrics for measuring sponsor engagement across multiple events
   - Create visual representations of sponsorship impact

3. **Marketplace Features**:
   - Add a marketplace for event organizers to list sponsorship opportunities
   - Enable sponsors to browse and directly apply for sponsorship opportunities
   - Implement a reputation system for both sponsors and event organizers

4. **Smart Contracts for Deliverables**:
   - Create conditional contracts that release funds based on specific deliverables
   - Implement dispute resolution mechanisms for sponsorship agreements
   - Develop templates for different types of sponsorship arrangements

5. **Mobile Applications**:
   - Develop companion mobile apps for real-time tracking of sponsorship activities
   - Enable push notifications for important sponsorship milestones
   - Facilitate on-the-go management of sponsor relationships

6. **Cross-Chain Functionality**:
   - Expand to multiple blockchain networks to increase accessibility
   - Implement cross-chain functionality for diverse sponsorship arrangements

## Key Features

The Sponsor Tracker smart contract currently includes the following key features:

1. **Sponsor Management**:
   - Add new sponsors with detailed information including name, contact info, and logo URI
   - Track wallet addresses associated with sponsors
   - Update sponsor information as needed
   - Toggle active/inactive status for sponsors

2. **Event Management**:
   - Create events with relevant details including name, description, and date
   - Associate sponsors with specific events
   - Track all events in a centralized system
   - Maintain active/inactive status for events

3. **Contribution Tracking**:
   - Record contributions from sponsors for specific events
   - Track contribution amounts and timestamps
   - Maintain a comprehensive history of all contributions
   - Add notes and details about each contribution

4. **Transparent Reporting**:
   - Access detailed information about events and sponsors
   - View contribution histories
   - Get aggregate statistics on sponsorships
   - Export data for reporting purposes

5. **Security Features**:
   - Owner-controlled access for sensitive operations
   - Ability to transfer ownership when needed
   - Data validation to ensure integrity
   - Immutable record of all transactions

6. **Analytics Capabilities**:
   - Track total contributions by sponsor
   - Monitor sponsor participation across events
   - Analyze event performance in terms of sponsorship
   - Measure contribution trends over time

## Technical Details

The Sponsor Tracker is built using Solidity version 0.8.17 and implements a comprehensive data model for managing sponsors, events, and contributions. The contract includes:

- Structured data models for sponsors, events, and contributions
- Comprehensive event logging for all major actions
- Access control mechanisms to protect sensitive operations
- Gas-efficient implementation of data storage
- Detailed documentation of all functions and structures

## Setup and Deployment

### Prerequisites
- Truffle or Hardhat development environment
- MetaMask or similar wallet provider
- Node.js and npm
- Access to an Ethereum network (testnet or mainnet)

### Deployment Steps
1. Clone the repository
2. Install dependencies: `npm install`
3. Compile the contract: `truffle compile` or `npx hardhat compile`
4. Deploy to network: `truffle migrate --network [network]` or `npx hardhat run scripts/deploy.js --network [network]`
5. Verify contract on Etherscan (optional): `truffle run verify SponsorTracker --network [network]` or equivalent Hardhat command

## Usage Guide

### For Contract Owners
1. Deploy the contract to establish ownership
2. Add sponsors using the `addSponsor` function
3. Create events using the `createEvent` function
4. Record contributions using the `recordContribution` function
5. Update sponsor or event details as needed

### For Developers
1. Interact with the contract using Web3.js or Ethers.js
2. Implement a frontend that calls the contract functions
3. Use events emitted by the contract to track state changes
4. Implement analytics using the data retrieval functions

## License

This project is licensed under the MIT License - see the LICENSE file for details.

##contract address
0xEe7814A06B519c395d025b37031d8347E1dA5e29
![image](https://github.com/user-attachments/assets/75e96150-a0aa-4e7a-ab6f-9c9fad66e6e7)


