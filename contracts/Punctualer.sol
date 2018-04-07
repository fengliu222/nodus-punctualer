pragma solidity ^0.4.21;

contract Punctualer {
    struct Player {
        address addr;
        uint balance;
        bytes32 phone;
    }

    Player[] players;
    address public owner;
    uint private cost;

    function Punctualer() public {
		owner = msg.sender;
        cost = 1;
	}

    function containPlayer(address addr) internal returns (bool) {
        for (uint i = 0; i < players.length ; i++) {
            Player storage p = players[i];
            if (p.addr == addr) {
                return true;
            }
        }
        return false;
    }

    function getPlayerWithAddress(address addr) internal returns (Player) {
        for (uint i = 0; i < players.length ; i++) {
            Player storage p = players[i];
            if (p.addr == addr) {
                return p;
            }
        }
        /* return Player(0, 0, 0); */
    }

    function getPlayerWithPhone(bytes32 phone) internal returns (Player) {
        for (uint i = 0; i < players.length ; i++) {
            Player storage p = players[i];
            if (p.phone == phone) {
                return p;
            }
        }
        /* return Player(0, 0, 0); */
    }

    function balanceOf(address addr) public returns (uint) {
        require(containPlayer(addr));
        Player memory p = getPlayerWithAddress(addr);
        return p.balance;
    }

    function participate(bytes32 phone) public payable {
        require(!containPlayer(msg.sender) && msg.value > cost);
        players.push(Player(msg.sender, msg.value, phone));
    }

    function redeem() public payable {
        require(containPlayer(msg.sender) && msg.value > cost);
        Player memory p = getPlayerWithAddress(msg.sender);
        p.balance += msg.value;
    }

    function withdraw(uint amount) public payable {
        Player memory p = getPlayerWithAddress(msg.sender);
        require(containPlayer(msg.sender) && p.balance > amount);
        p.balance -= amount;

        // send to players account
        msg.sender.transfer(amount);
    }

    function totalCost(uint number) internal view returns (uint) {
        return number * cost;
    }

    function draw(bytes32[] lazyPhones) public {
        // take in bytes32 array
        uint totalC = totalCost(lazyPhones.length);
        for (uint i = 0; i < lazyPhones.length; i++) {
            bytes32 phone = lazyPhones[i];
            for (uint j = 0; j < players.length; j++) {
                Player storage p = players[j];
                if (p.phone == phone) {
                    p.balance -= cost;
                } else {
                    p.balance += totalC / (players.length - lazyPhones.length);
                }
            }
        }
    }
}
