
pragma solidity >=0.4.22 <0.6.0;
  
contract kyc {
  
    struct Organisme {
            string oid;
            string name;
            //address[] agents; // an organisme can have multiple agents
        }

  
    struct Client {
            string uuid;
            string cin;
            uint tel;
            string status;
            
        }

    mapping(string=>string) cinToUuid;
    mapping(string=>Organisme) organismes;
    mapping(string=>Client) clients;
    mapping (address => string) affiliations; //msg.sender=>oid maping personal eth address to organism oid
    mapping (string=> string[]) ownership; //uuid =>list oids
    



    function addOrganisme (string memory oid,string memory name) public returns (bool){//oid and organime's name //return oid wich will be the hash of the name to use it in the front end also
     
    addpersonel(oid,msg.sender);
    organismes[oid]=Organisme({oid: oid, name: name});
    return true;
         }
         
    function addpersonel(string memory oid,address personel) public {
        
        affiliations[personel]=oid;
    }

    event clientAdded(string indexed uuid, string indexed cin, uint tel, string oid, string status, uint date);        
    function addClient (string memory uuid, string memory cin, uint  tel ,string memory oid) public returns (bool) {
        
         ///owners.push("nnn");
        clients[uuid]=Client({uuid:uuid,cin:cin, tel:tel, status:"pending"});
        ownership[uuid].push(oid);
        cinToUuid[cin]=uuid;
        emit clientAdded(uuid,cin,tel,oid,"pending",now);
        return true;

         }
         
    function isowner(string memory oid, string memory uuid) internal view returns (bool) { //check if oid is owner and has right over personal data
            
            string[] storage arr=ownership[uuid];
            for (uint8 i=0; i<arr.length;i++){
                if(compareStrings(arr[i],oid))
                return true;
            }
            return false;
        }

    event clientValidated(string indexed uuid, string status, uint date);        
         
    function validateClientByUuid (string memory uuid) public returns (bool) {
             clients[uuid].status="valid";
             emit clientValidated(uuid,"valid",now);
             return true;
         }
         
    function validateClientByCin (string memory cin) public returns (bool) {
             string memory uuid= cinToUuid[cin];
             clients[uuid].status="valid";
             emit clientValidated(uuid,"valid",now);

             return true;
         }
         
         
    event clientBlocked(string indexed uuid, string indexed cin, uint tel, string status, string date);        

    function invalidateClientKycbyuuid (string memory uuid) public returns (bool) {
               clients[uuid].status="unvalid";
             return true;
         }
        
     function invalidateClientByCin (string memory cin) public returns (bool) {
             string memory uuid= cinToUuid[cin];
             clients[uuid].status="unvalid";
             return true;
         }        
         
    function addOwnerOrganisme(string memory oid ,string memory uuid) public returns (bool){//attribute access right to an organisme
        string[] storage ownershipArray=ownership[uuid];
        ownershipArray.push(oid);
        return true;
    }
    
    function checkKycByCin(string memory cin) public view returns ( string memory) {
     
      string memory uuid= cinToUuid[cin];
      string memory status= clients[uuid].status;
      return status;
        }
        
    function checkKycByUuid( string memory uuid) public view returns (string memory) {
           string memory status= clients[uuid].status;
         return status;
        }
        
           function compareStrings (string memory a, string memory b) public pure  returns (bool) {
                return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))) );

       }
    }


