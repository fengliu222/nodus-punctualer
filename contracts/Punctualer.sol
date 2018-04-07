pragma solidity ^0.4.21;

contract Punctualer {
    struct Player {
        uint balance;
        bytes32 phone;
    }

    mapping (address => Player) public players;
    address public owner;
    uint private cost;

    function Punctualer() public {
		owner = msg.sender;
        cost = 1;
	}

    function participate(bytes32 phone) public payable {
        require(players[msg.sender].phone == 0 && msg.value > cost);
        players[msg.sender] = Player(msg.value, phone);
    }

    function redeem() public payable {
        require(players[msg.sender].phone != 0 && msg.value > cost);
        Player storage p = players[msg.sender];
        p.balance += msg.value;
    }

    function withdraw(uint amount) public payable {
        require(players[msg.sender].phone != 0 && players[msg.sender].balance > amount);
        Player storage p = players[msg.sender];
        p.balance -= amount;

        // send to players account
        msg.sender.transfer(amount);
    }

    function draw(bytes32[] lazyPhones) public {
        // take in bytes32 array
        for (uint i = 0; i < lazyPhones.length; i++) {
            bytes32 phone = lazyPhones[i];
            /* for (uint j = 0; j < players.length; j++) {
                Player storage p = players[msg.seer];
            } */
        }
    }
}
