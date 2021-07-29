pragma solidity 0.6.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MinerNFT is ERC721, Ownable {

    address public VRFCoordinator;
    address public LinkToken;
    bytes32 internal keyHash;
    uint256 internal fee;

    bytes3[] public colors;
    mapping(bytes3 => bool) private _colorExists;

    uint256 public tokenCounter;

    struct Miner {
        string MAC_hash;
        string Id;
    }

    Miner[] public miners;

    constructor(address _VRFCoordinator, address _LinkToken, bytes32 _keyhash) ERC721("MinerNFT", "MNFT") public {
        VRFCoordinator = _VRFCoordinator;
        LinkToken = _LinkToken;
        keyHash = _keyhash;
        fee = 0.1 * 10**18; // 0.1 LINK
    }

    function newMiner(string memory metadata) public returns (uint256) {
        //require(msg.sender, owner());
        uint256 newMinerId = tokenCounter;
        _mint(msg.sender, newMinerId);
        _setTokenURI(newMinerId, metadata);
        tokenCounter = tokenCounter + 1;
        return newMinerId;
    }

    function mint(bytes3 _color) public {
        // require(!_colorExists[_color], "color exists");
        // colors.push(_color);
        // uint256 newMinerId = tokenCounter;
        // _mint(msg.sender, newMinerId);
        // tokenCounter = tokenCounter + 1;
        // _colorExists[_color] = true;

        require(!_colorExists[_color], "color exists");
        colors.push(_color);
        uint _id = colors.length - 1;
        _mint(msg.sender, _id);
        _colorExists[_color] = true;
    }

    function getNumberOfMiners() public view returns (uint256) {
        return miners.length;
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        return tokenURI(tokenId);
    }

    function setTokenURI(uint256 tokenId, string memory _tokenURI) public {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );
        _setTokenURI(tokenId, _tokenURI);
    }

}