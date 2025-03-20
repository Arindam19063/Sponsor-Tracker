// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title SponsorTracker
 * @dev Contract for managing and tracking sponsors for various events
 */
contract SponsorTracker {
    // Contract owner
    address public owner;
    
    // Counter for sponsor IDs
    uint256 private sponsorIdCounter;
    // Counter for event IDs
    uint256 private eventIdCounter;
    
    // Sponsor structure
    struct Sponsor {
        uint256 id;
        string name;
        string contactInfo;
        string logoURI;
        address walletAddress;
        uint256 totalContributions;
        bool isActive;
    }
    
    // Event structure
    struct Event {
        uint256 id;
        string name;
        string description;
        uint256 date;
        bool isActive;
        uint256[] sponsorIds;
        mapping(uint256 => uint256) sponsorContributions; // sponsorId => contribution amount
    }
    
    // Contribution structure for tracking history
    struct Contribution {
        uint256 sponsorId;
        uint256 eventId;
        uint256 amount;
        uint256 timestamp;
        string notes;
    }
    
    // Mappings
    mapping(uint256 => Sponsor) public sponsors;
    mapping(uint256 => Event) private events;
    mapping(address => uint256) private walletToSponsorId;
    Contribution[] public contributionHistory;
    
    // Events
    event SponsorAdded(uint256 indexed sponsorId, string name);
    event SponsorUpdated(uint256 indexed sponsorId);
    event EventAdded(uint256 indexed eventId, string name);
    event EventUpdated(uint256 indexed eventId);
    event ContributionRecorded(uint256 indexed sponsorId, uint256 indexed eventId, uint256 amount);
    
    /**
     * @dev Constructor
     */
    constructor() {
        owner = msg.sender;
        sponsorIdCounter = 1;
        eventIdCounter = 1;
    }
    
    /**
     * @dev Modifier to check if caller is the contract owner
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "SponsorTracker: Caller is not the owner");
        _;
    }
    
    /**
     * @dev Add a new sponsor
     * @param _name Name of the sponsor
     * @param _contactInfo Contact information of the sponsor
     * @param _logoURI URI for the sponsor's logo
     * @param _walletAddress Wallet address of the sponsor
     * @return sponsorId ID of the newly created sponsor
     */
    function addSponsor(
        string memory _name,
        string memory _contactInfo,
        string memory _logoURI,
        address _walletAddress
    ) public onlyOwner returns (uint256) {
        require(_walletAddress != address(0), "SponsorTracker: Invalid wallet address");
        require(walletToSponsorId[_walletAddress] == 0, "SponsorTracker: Wallet address already in use");
        
        uint256 sponsorId = sponsorIdCounter;
        sponsorIdCounter++;
        
        sponsors[sponsorId] = Sponsor({
            id: sponsorId,
            name: _name,
            contactInfo: _contactInfo,
            logoURI: _logoURI,
            walletAddress: _walletAddress,
            totalContributions: 0,
            isActive: true
        });
        
        walletToSponsorId[_walletAddress] = sponsorId;
        
        emit SponsorAdded(sponsorId, _name);
        return sponsorId;
    }
    
    /**
     * @dev Update an existing sponsor
     * @param _sponsorId ID of the sponsor to update
     * @param _name Name of the sponsor
     * @param _contactInfo Contact information of the sponsor
     * @param _logoURI URI for the sponsor's logo
     * @param _isActive Status of the sponsor
     */
    function updateSponsor(
        uint256 _sponsorId,
        string memory _name,
        string memory _contactInfo,
        string memory _logoURI,
        bool _isActive
    ) public onlyOwner {
        require(_sponsorId > 0 && _sponsorId < sponsorIdCounter, "SponsorTracker: Sponsor does not exist");
        
        Sponsor storage sponsor = sponsors[_sponsorId];
        sponsor.name = _name;
        sponsor.contactInfo = _contactInfo;
        sponsor.logoURI = _logoURI;
        sponsor.isActive = _isActive;
        
        emit SponsorUpdated(_sponsorId);
    }
    
    /**
     * @dev Create a new event
     * @param _name Name of the event
     * @param _description Description of the event
     * @param _date Date of the event (UNIX timestamp)
     * @return eventId ID of the newly created event
     */
    function createEvent(
        string memory _name,
        string memory _description,
        uint256 _date
    ) public onlyOwner returns (uint256) {
        uint256 eventId = eventIdCounter;
        eventIdCounter++;
        
        Event storage newEvent = events[eventId];
        newEvent.id = eventId;
        newEvent.name = _name;
        newEvent.description = _description;
        newEvent.date = _date;
        newEvent.isActive = true;
        
        emit EventAdded(eventId, _name);
        return eventId;
    }
    
    /**
     * @dev Update an existing event
     * @param _eventId ID of the event to update
     * @param _name Name of the event
     * @param _description Description of the event
     * @param _date Date of the event (UNIX timestamp)
     * @param _isActive Status of the event
     */
    function updateEvent(
        uint256 _eventId,
        string memory _name,
        string memory _description,
        uint256 _date,
        bool _isActive
    ) public onlyOwner {
        require(_eventId > 0 && _eventId < eventIdCounter, "SponsorTracker: Event does not exist");
        
        Event storage eventData = events[_eventId];
        eventData.name = _name;
        eventData.description = _description;
        eventData.date = _date;
        eventData.isActive = _isActive;
        
        emit EventUpdated(_eventId);
    }
    
    /**
     * @dev Record a contribution from a sponsor for an event
     * @param _sponsorId ID of the sponsor
     * @param _eventId ID of the event
     * @param _amount Amount contributed
     * @param _notes Additional notes about the contribution
     */
    function recordContribution(
        uint256 _sponsorId,
        uint256 _eventId,
        uint256 _amount,
        string memory _notes
    ) public onlyOwner {
        require(_sponsorId > 0 && _sponsorId < sponsorIdCounter, "SponsorTracker: Sponsor does not exist");
        require(_eventId > 0 && _eventId < eventIdCounter, "SponsorTracker: Event does not exist");
        require(sponsors[_sponsorId].isActive, "SponsorTracker: Sponsor is not active");
        require(events[_eventId].isActive, "SponsorTracker: Event is not active");
        
        // Update event sponsor list if not already added
        bool sponsorExists = false;
        for (uint i = 0; i < events[_eventId].sponsorIds.length; i++) {
            if (events[_eventId].sponsorIds[i] == _sponsorId) {
                sponsorExists = true;
                break;
            }
        }
        
        if (!sponsorExists) {
            events[_eventId].sponsorIds.push(_sponsorId);
        }
        
        // Update contribution amounts
        events[_eventId].sponsorContributions[_sponsorId] += _amount;
        sponsors[_sponsorId].totalContributions += _amount;
        
        // Record in history
        contributionHistory.push(Contribution({
            sponsorId: _sponsorId,
            eventId: _eventId,
            amount: _amount,
            timestamp: block.timestamp,
            notes: _notes
        }));
        
        emit ContributionRecorded(_sponsorId, _eventId, _amount);
    }
    
    /**
     * @dev Get event details
     * @param _eventId ID of the event
     * @return id ID of the event
     * @return name Name of the event
     * @return description Description of the event
     * @return date Date of the event
     * @return isActive Status of the event
     * @return sponsorIds Array of sponsor IDs for the event
     */
    function getEventDetails(uint256 _eventId) public view returns (
        uint256 id,
        string memory name,
        string memory description,
        uint256 date,
        bool isActive,
        uint256[] memory sponsorIds
    ) {
        require(_eventId > 0 && _eventId < eventIdCounter, "SponsorTracker: Event does not exist");
        
        Event storage eventData = events[_eventId];
        return (
            eventData.id,
            eventData.name,
            eventData.description,
            eventData.date,
            eventData.isActive,
            eventData.sponsorIds
        );
    }
    
    /**
     * @dev Get sponsor contribution for an event
     * @param _eventId ID of the event
     * @param _sponsorId ID of the sponsor
     * @return Amount contributed by the sponsor for the event
     */
    function getSponsorContribution(uint256 _eventId, uint256 _sponsorId) public view returns (uint256) {
        require(_eventId > 0 && _eventId < eventIdCounter, "SponsorTracker: Event does not exist");
        require(_sponsorId > 0 && _sponsorId < sponsorIdCounter, "SponsorTracker: Sponsor does not exist");
        
        return events[_eventId].sponsorContributions[_sponsorId];
    }
    
    /**
     * @dev Get total number of sponsors
     * @return Total number of sponsors
     */
    function getTotalSponsors() public view returns (uint256) {
        return sponsorIdCounter - 1;
    }
    
    /**
     * @dev Get total number of events
     * @return Total number of events
     */
    function getTotalEvents() public view returns (uint256) {
        return eventIdCounter -
         1;
    }
    
    /**
     * @dev Get total number of contributions
     * @return Total number of contributions
     */
    function getTotalContributions() public view returns (uint256) {
        return contributionHistory.length;
    }
    
    /**
     * @dev Transfer ownership of the contract
     * @param _newOwner Address of the new owner
     */
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "SponsorTracker: New owner cannot be the zero address");
        owner = _newOwner;
    }
}
