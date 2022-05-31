//  SSPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract LandContract {
    struct landRegistry {
        address landId;
        string area;
        string city;
        string state;
        uint landPrice;
        uint propertyPID;

    }
    struct buyerDetail{
        string name;
      uint  age; 
    string city; 
uint CNIC; 
string email; }
    struct sellerDetail{
        string name;
      uint age; 
    string city; 
uint CNIC; 
string email; 

    }
    struct landInspectorDetail{
        address id;
        string name;
        uint age;
        string destination;
    }


  mapping(address => landInspectorDetail) public Inspector;
mapping (address => sellerDetail )   public sellerRegister;
    mapping (address =>landRegistry)public AddLand;
mapping (address => buyerDetail ) buyerRegister;


mapping (address => address) private landinspector;
mapping (address => bool) public sellerregister;
mapping (address => bool) public buyerregister;
    mapping (address =>bool) public sellerVerify;
    mapping (address =>bool) public sellerRejected;
    mapping (address =>bool)public buyerVerify;
    mapping (address =>bool)public buyerReject;
    mapping(address => bool)public landVerify;
mapping (uint => address) public landOwner;
mapping(uint => bool) public receievePayment;


address public landInspector;
uint public inspectorAdd;
uint public landAdd;
uint public sellerAdd;
uint public buyerAdd;

event registration (address _id);
event LandAdd (address _landId);
 event verify(address _id);
 event reject(address _id);




constructor()  {
landInspector == msg.sender ;
landInspectorAdd( 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, "hamza", 21, "disrrict");
}
function landInspectorAdd ( address _id, string memory _name, uint _age,  string memory _destination) private  {

inspectorAdd++;
Inspector[msg.sender]=landInspectorDetail (_id,  _name, _age,  _destination);
landinspector[_id]=msg.sender;
}


   


    
// seller

function sellerRegisters(  string memory _name, uint _age, string memory _city, uint _CNIC, string memory _email )public{
    require(!sellerregister[msg.sender]);
sellerregister[msg.sender]= true;
    sellerRegister[msg.sender]=sellerDetail( _name, _age, _city, _CNIC, _email);
    sellerAdd++;
    landOwner[sellerAdd]=msg.sender;
    emit registration(msg.sender);
}


function sellerVerification (address seller_id)public  {
    require(verifyFromInspector  (msg.sender));
    sellerVerify[seller_id]=true;
    emit verify(seller_id);
}

function sellerReject(address seller_id)public{
    require(verifyFromInspector  (msg.sender));
sellerRejected[seller_id] = true;
emit reject(seller_id);
}

function addLand(  address _landId, string memory _area, string memory _city, string memory _state, 
 uint _landPrice, uint _propertyPID ) public {
     require(SellerisVerified(msg.sender), "you are not verified");
        require(sellerregister[msg.sender] , "you are not register");
    landAdd++;
    AddLand [msg.sender]=landRegistry (_landId, _area, _city, _state, _landPrice, _propertyPID);
emit LandAdd(_landId);
        }

        function landverify(address _landId)public{
require(verifyFromInspector  (msg.sender));
landVerify[_landId] = true;
        }
      
function sellerUpdate( string memory _name, uint _age, string memory _city, uint _CNIC, string memory _email )public{
    require(sellerregister[msg.sender]);

sellerRegister[msg.sender].name=_name;
sellerRegister[msg.sender].age=_age; 
sellerRegister[msg.sender].city=_city;
sellerRegister[msg.sender].CNIC=_CNIC;
sellerRegister[msg.sender].email=_email;
   
}

function SellerisVerified(address _id)public view returns(bool ){
   
    if(sellerVerify[_id]){
        return true;
    }
    else{return false;
    }
    }

function SellerNotVerified(address _id)public view returns(bool ){
    if(sellerRejected[_id]){
        return true;
    }
    else{return false;
    }}


    function landDetail(address _landId )public view returns(address , string memory, string memory, string memory, uint, uint ){
    return (AddLand[_landId].landId , AddLand[_landId].area ,AddLand[_landId].city, AddLand[_landId].state, AddLand[_landId].landPrice, AddLand[_landId].propertyPID );
}

function Landowner(uint _landId)public view returns(address){
return landOwner[_landId];
}


// we can individual check

function LandOwner(uint _landId)public view returns(address){
return landOwner[_landId];
}

function landIsVerified(address _id)public view returns(bool ) {
if(landVerify[_id]){
    return true;
}
else{return false;
    }
}

function SellerIsVerified(address _id)public view returns(bool ){
    if(sellerVerify[_id]){
        return true;
    }
    else{return false;
    }
    }

function buyerIsVerified(address _id)public view returns(bool  ){
if(buyerVerify[_id]){
    return true;
}
else{return false;
    }}

function LandInspector(address _id)public view returns(address){
return landinspector[_id] ;
}

 function GetLandCity(address i)public view returns (string memory){
return AddLand[i].city;
}

function GetLandPrice(address i)public view returns(uint) {
return AddLand[i].landPrice;
}

function GetArea(address i)public view returns (string memory){
return AddLand[i].area;
}

function isBuyer(address _id)public view returns(bool ){
if(buyerregister [ _id]){
    return true;
}
else{return false;
    }}

function isSeller (address _id)public view returns(bool ) {
if(sellerregister[_id]){
    return true;
}
else{return false;
    }}

function verifyFromInspector(address _id) public view returns( bool) {
    

    if(landInspector == _id){
        return true;
    }
    else{
       return false;
    }}


// buyer

function registerBuyer(string memory _name, uint _age, string memory _city, uint _CNIC, string memory _email)public{
   require(!buyerregister[msg.sender]);
buyerregister[msg.sender]=true;
    buyerAdd++;
buyerRegister[msg.sender]=buyerDetail(_name, _age, _city, _CNIC, _email);
emit registration(msg.sender);
}

function BuyerVerify(address _id)public{
    require(verifyFromInspector(msg.sender));
buyerVerify[_id]=true;
emit verify(_id);
    }

function BuyerReject(address _id)public{
require(verifyFromInspector (msg.sender));
buyerReject[_id]=true;
emit reject (_id);
}
    
    function updateBuyer (string memory _name, uint _age, string memory _city, uint _CNIC, string memory _email)public{
    require(buyerregister[msg.sender]);
    buyerRegister[msg.sender].name=_name;
    buyerRegister[msg.sender].age=_age;
    buyerRegister[msg.sender].city=_city;
    buyerRegister[msg.sender].CNIC=_CNIC;
    buyerRegister[msg.sender].email=_email;

}
function buyerisVerified(address _id)public view returns(bool ){
if(buyerVerify[_id]){
    return true;
}
else{return false;
    }}

function buyerNotVerified(address _id)public view returns(bool){
if(buyerReject[_id]){
    return true;
}
else{return false;
    }}

function currentOwnerLand(uint _landId)public view returns(address){
return landOwner[_landId];
}


//  TRANSFER OWNER SHIP

function ownerShipTransfer(uint _landId, address _newOwner)public{
 require(verifyFromInspector (msg.sender));
landOwner[_landId]=_newOwner;
}


function payment( address payable _to, uint _landId )public payable  {
     require(verifyFromInspector (msg.sender));
receievePayment[_landId]=true;
_to.transfer(msg.value);
landOwner[_landId]=_to;
}

}
