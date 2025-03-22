// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SolidityTypes {
    function useBool(bool c) public pure returns (bool) {
        bool a = true;
        bool b = false;
        return a && b && c;
    }

    function useUint(uint256 c) public pure returns (uint256) {
        // these are unsigned integers
        uint256 a = 1;
        uint256 b = 2; // equals to uint256
        return a + b + c;
    }

    function useInt(int256 c) public pure returns (int256) {
        // these are signed integers
        int256 a = 1;
        int256 b = 2; // equals to int256
        return a + b + c;
    }

    function useAddress() public pure returns (address) {
        // these are addresses
        address a = address(0x1);
        return a;
    }

    function useBytes() public pure returns (bytes32) {
        // these are bytes
        bytes32 a = "0x1";
        return a;
    }
}

contract SolidityVisibilty {
    // A public function can be called from:
    // - functions within the main contract
    // - functions within a derived contract
    // - functions within third party contracts
    function useVisibility() public pure returns (uint256) {
        uint256 a = 1;
        return a;
    }

    // A internal function can be called from:
    // - functions within the main contract
    // - functions within a derived contract
    function useVisibilityInternal() internal pure returns (uint256) {
        uint256 a = 1;
        return a;
    }

    // A private function can be called from:
    // - functions within the main contract
    function useVisibilityPrivate() private pure returns (uint256) {
        uint256 a = 1;
        return a;
    }

    // An external function can be called from:
    // - functions within third party contracts
    function useVisibilityExternal() external pure returns (uint256) {
        uint256 a = 1;
        return a;
    }
}

contract SolidityEvents {
    // An event type declaration.
    // It can be used to emit events from functions. Events are stored in the blockchain in the transaction logs.
    // The address is indexed, this means that it can be used to filter the events.
    event Transfer(address indexed from, address to, uint256 value);

    function emitTransfer(address from, address to, uint256 value) public {
        // emit an event of type Transfer
        emit Transfer(from, to, value);
    }
}

contract SolidityModifiers {
    address owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _; // This indicates where the function is executed
    }

    // If more than one modifier is declared, they are executed in the order they are declared
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    // A modifier with a parameter
    modifier onlyAllowedUser(address user) {
        require(msg.sender == user);
        _;
    }

    function updateData(uint256 id, bytes32 newData, address user) public onlyAllowedUser(user) {
        // function body
    }

    // A pure function cannot modify or access the state
    function pureFunction() public pure returns (uint256) {
        return 1;
    }

    // A view function cannot modify the state
    function viewFunction() public view returns (address) {
        return owner;
    }

    // A payable function can receive ether
    function receiveEther() public payable returns (address, uint256) {
        uint received = msg.value;
        address from = msg.sender;
        return (from, received);
    }

    // A virtual function can be overridden in a derived contract
    function virtualFunction() public virtual {
        // function body
    }

}

contract SolidityArrays {
    // Dynamic array
    uint256[] public numbers;
    // Fixed-size array
    uint256[2] public numbers2;

    function addNumber(uint256 number) public {
        // Add to a dynamic array
        numbers[0] = number;
        // or to append:
        numbers.push(number);

        // Add to a fixed-size array
        numbers2[0] = number;

        // Cannot push on a fixed-size array
        // numbers2.push(number);  ERROR

        uint256[] memory numbers3;

        numbers3[0] = 1;

        // Cannot push to a memory array
        // numbers3.push(1); ERROR
    }

    function getNumber(uint256 index) public view returns (uint256) {
        return numbers[index];
    }

    function getNumber2(uint256 index) public view returns (uint256) {
        return numbers2[index];
    }

    function getLength() public view returns (uint256) {
        return numbers.length;
    }

    function deleteNumber(uint256 index) public {
        delete numbers[index];
    }
}

contract SolidityDataLocation {
    struct MyData {
        uint256 a;
    }

    // Storage variable by default
    uint256[] public myFavoriteNumbers;
    MyData[] public myFavoriteData;

    function setFavoriteNumber(MyData memory memory_data, MyData calldata calldata_data) public {
        // calldata_data.a = 1; ERROR - calldata is read-only

        // function variables are stored in memory by default
        uint256 a = 1;
        memory_data.a = a;
        memory_data.a = calldata_data.a;
        myFavoriteData.push(memory_data);
    }
}

contract SolidityStructs {
    struct User {
        address _add;
        string name;
        string work;
        uint256 age;
    }

    function foo(address _add) public pure {
        User memory user1 = User(_add, "Ufo", "Developer", 30);
        user1._add = _add;

        delete user1._add;
    }
}

contract SolidityMapping {

    struct User {
        address _add;
    }

    mapping(address => uint256) public balances;
    mapping(address => User) public users;

    function getBalance(address account) public view returns (uint256) {
        // If the account has no balance, return 0. Mappings return default values if the key is not set
        return balances[account];
    }

    function setBalance(address account, uint256 amount) public {
        balances[account] = amount;
    }

    function deleteBalance(address account) public {
        delete balances[account];
    }
}

contract SolidityExceptions {
    
    uint demo_var = 10;

    function useAssert(uint input) public view returns (uint256) {
        // assert that demo_var is divisible by input
        assert(demo_var%input == 0);

        return demo_var / input;
    }   

    function useRequire(uint input) public view returns (uint256) {
        // require that demo_var is divisible by input
        require(demo_var%input == 0, "Invalid input");

        return demo_var / input;
    }   

     function useRevert(uint input) public view returns (uint256) {
        // revert if demo_var is divisible by input
        if (demo_var%input == 0) {
            revert("Invalid input");
        }

        return demo_var / input;
     }

     event Log(string message);
    event LogBytes(bytes data);

    ExternalContractWithException public foo;

    constructor() {
        // This ExternalContractWithException contract is used for example of try catch with external call
        foo = new ExternalContractWithException(msg.sender);
    }

    // Example of try / catch with external call
    // tryCatchExternalCall(0) => Log("external call failed")
    // tryCatchExternalCall(1) => Log("my func was called")
    function tryCatchExternalCall(uint256 _i) public {
        try foo.myFunc(_i) returns (string memory result) {
            emit Log(result);
        } catch {
            emit Log("external call failed");
        }
    }

    // Example of try / catch with contract creation
    // tryCatchNewContract(0x0000000000000000000000000000000000000000) => Log("invalid address")
    // tryCatchNewContract(0x0000000000000000000000000000000000000001) => LogBytes("")
    // tryCatchNewContract(0x0000000000000000000000000000000000000002) => Log("Foo created")
    function tryCatchNewContract(address _owner) public {
        try new ExternalContractWithException(_owner) {
            // you can use variable foo here
            emit Log("Foo created");
        } catch Error(string memory reason) {
            // catch failing revert() and require()
            emit Log(reason);
        } catch (bytes memory reason) {
            // catch failing assert()
            emit LogBytes(reason);
        }
    }

}

// External contract used for try / catch examples
contract ExternalContractWithException {
    address public owner;

    constructor(address _owner) {
        require(_owner != address(0), "invalid address");
        owner = _owner;
    }

    function myFunc(uint256 x) public pure returns (string memory) {
        require(x != 0, "require failed");
        return "my func was called";
    }
}
