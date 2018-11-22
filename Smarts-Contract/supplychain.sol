pragma solidity ^0.4.11;

contract supply_Chain {
    
    uint public _p_id =0;
    uint public _u_id =0;
    uint public _t_id=0;
    

    address login_user = msg.sender;
    // zain
    struct track_product {
        bytes32 _track_id;
        bytes32 _product_id;
        bytes32 _owner_id;
        address _product_owner;
        uint _timeStamp;
    }
    mapping(bytes32 => track_product) public tracks;
    bytes32[] public tracks_indexes;
    
    struct product {
        bytes32 _product_id;
        string _product_name;
        uint _product_cost;
        string _product_specs;
        string _product_review;
        address _product_owner;
        uint _manufacture_date;
        string _status;
        
    }
    
    mapping(bytes32 => product) public products;
    bytes32[] public product_indexes;
    
    struct participant {
        bytes32 _user_id;
        string _userName;
        string _passWord;
        address _address;
        string _userType;
    }
    
    mapping(address => participant) public participants;
    address[] public participant_addresses;
    
    struct IpfsHash {
        string image_hash;
        string image_name;
    }
    
    mapping(bytes32 => IpfsHash) public ipfs_hashs;
    
    
    modifier onlyNewAccount {
        require(participants[msg.sender]._user_id == "");
        _;
    }
    
    modifier onlyOwner(bytes32 pid) {
         if(msg.sender != products[pid]._product_owner ) revert();
         _;
         
     }
    
    
    function createParticipant(string name ,string pass ,string utype, string image_hash, string image_name) onlyNewAccount public returns (bytes32){
        
        bytes32 id_hash = keccak256(abi.encodePacked(_u_id++, name, pass, msg.sender, utype));
        
        participants[msg.sender]._user_id = id_hash ;
        participants[msg.sender]._userName = name ;
        participants[msg.sender]._passWord = pass;
        participants[msg.sender]._address = msg.sender;
        participants[msg.sender]._userType = utype;
        ipfs_hashs[id_hash].image_hash = image_hash;
        ipfs_hashs[id_hash].image_name = image_name;
        
        participant_addresses.push(msg.sender);
        
        return id_hash;
    }
    
    function newProduct(string name ,uint p_cost ,string p_specs ,string p_review, string image_hash, string image_name) public returns (bytes32) {
        
        require(keccak256(abi.encodePacked(participants[msg.sender]._userType)) == keccak256(abi.encodePacked("Manufacturer")));
        
        bytes32 id_hash = keccak256(abi.encodePacked(_p_id++, name, p_cost, p_specs, p_review, now));
        
        products[id_hash]._product_id = id_hash;
        products[id_hash]._product_name = name;
        products[id_hash]._product_cost = p_cost;
        products[id_hash]._product_specs =p_specs;
        products[id_hash]._product_review =p_review;
        products[id_hash]._product_owner = msg.sender;
        products[id_hash]._manufacture_date = now;
        products[id_hash]._status = "Manufacturer";
        
        ipfs_hashs[id_hash].image_hash = image_hash;
        ipfs_hashs[id_hash].image_name = image_name;
        
        product_indexes.push(id_hash);
        
        transferOwnership_product(msg.sender, id_hash, msg.sender);
        
        return id_hash;
    }

  
     
    function transferOwnership_product(address user2_address, bytes32 prod_id, address user1_address) onlyOwner(prod_id) public returns(bytes32, address, string) {
        
        bytes32 id_hash = keccak256(abi.encodePacked(_t_id++, participants[user1_address]._user_id, participants[user2_address]._user_id,  now));
        
        tracks[id_hash]._product_id =prod_id;
        tracks[id_hash]._product_owner = participants[user2_address]._address;
        tracks[id_hash]._owner_id = participants[user2_address]._user_id;
        tracks[id_hash]._timeStamp = now;
        tracks[id_hash]._track_id = id_hash;
        
        products[prod_id]._product_owner = participants[user2_address]._address;
        products[prod_id]._status = participants[user2_address]._userType;
            
        tracks_indexes.push(id_hash);                    
        
        return (tracks[id_hash]._track_id,tracks[id_hash]._product_owner,products[prod_id]._status);
    }
   
    function userLogin(string uname ,string pass) view public returns (bool){
        
            if(keccak256(abi.encodePacked(participants[msg.sender]._userName)) == keccak256(abi.encodePacked(uname))) {
                if(keccak256(abi.encodePacked(participants[msg.sender]._passWord))==keccak256(abi.encodePacked(pass))) {
                    return true;
                }
            }
        
        
        return false;
    }
    
}