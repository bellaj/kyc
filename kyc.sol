
pragma solidity >=0.4.22 <0.6.0;
  
contract kyc {
  
struct Organisme {
        uint oid;
        string name;
    }

  
struct User {
        string uuid;
        string cin;
        uint tel;
        uint[] ownersIds;
        bool isvalid;
        
    }

mapping(uint=>Organisme) organismes;
mapping(string=>User) users;


function addOrganisme (string memory name) public  {//oid and organime's name //return oid wich will be the hash of the name to use it in the front end also
 

     }
    
function addClient (string memory cin, uint  tel) public {
         
     }
     
     
function validateClientKyc (string memory uuid) public {
         
     }
     
function blockClientKyc (string memory uuid) public {
         
     }
     
function addOwner(uint oid ,string memory uuid) public {//add it to the user's info owners
    
}

function checkKycByCin(string memory cin) public view returns (bool) {
 
    }
    
function checkKycByUuid( string memory uuid) public view returns (bool) {
 
    }
}
