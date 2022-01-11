/*

Integrated Token, Presale & Airdrop contract.

Pertinent Variables: 


   Fill these in below (in the constructor, not this comment!)

   ## these are just examples, the real ones are half way down the page ##

           // token ticker - keep it short, I stay max 5 chars
        symbol = "TKN"; 

        // token name - again, don't write a novel here. I go 10-15 chars or so.
        // a web address fits if it is short.
        name = "TOKEN"; 

        // how many decimals to allow
        decimals = 18; 

        // 10m total
        totalSupply = 10000000000000000000000000; 

        // minimum spend 0.02 ether
        minimumBuy = 20000000000000000; 

        // presale price 50 tokens per ether
        tokensPerEth = 50000000000000000000; 

        // airdrop balance, 5m
        airdropBalance = 5000000000000000000000000; 

        // presale balance, 5m  
        presaleBalance = 5000000000000000000000000; 

*/
pragma solidity ^0.4.26;

 interface IERC20 
 {
  function totalSupply() external view returns (uint256);
  function balanceOf(address who) external view returns (uint256);
  function allowance(address owner, address spender) external view returns (uint256);
  function transfer(address to, uint256 value) external returns (bool);
  function approve(address spender, uint256 value) external returns (bool);
  function transferFrom(address from, address to, uint256 value) external returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
 }

 library SafeMath 
 {

    function mul(uint256 a, uint256 b) internal pure returns (uint256) 
    {
        if (a == 0) 
        {
            return 0;
        } 
        else 
        {
            uint256 c = a * b;
            require(c / a == b);
            return c;
        }
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) 
    {
        require(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256 c) 
    {
        c = a + b;
        require(c >= a);
        return c;
    }
 }

contract ERC20Basic 
{
    uint256 public totalSupply;
    function balanceOf(address who) public constant returns (uint256);
    function transfer(address to, uint256 value) public returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract ERC20 is ERC20Basic 
{
    function allowance(address owner, address spender) public constant returns (uint256);
    function transferFrom(address from, address to, uint256 value) public returns (bool);
    function approve(address spender, uint256 value) public returns (bool);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract MyToken is ERC20 
{    
    using SafeMath for uint256;

    // Declare owner as message sender here only
    // Do NOT do so anywhere else!
    address owner = msg.sender;

    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;

    string public symbol;
    string public  name;
    uint8 public decimals;
    uint256 public totalSupply;
    uint256 public totalDistributed;
    uint256 public minimumBuy;
    uint256 public tokensPerEth;
    uint256 public airdropBalance;
    uint256 public presaleBalance;

    // Constructor
    /////////////////////////////////////////////////////////
    constructor() public 
    {
        // token ticker - keep it short, I stay max 5 chars
        symbol = "TKN"; 

        // token name - again, don't write a novel here. I go 10-15 chars or so.
        // a web address fits if it is short.
        name = "TOKEN"; 

        // how many decimals to allow
        decimals = 18; 

        // 10m total
        totalSupply = 10000000000000000000000000; 

        // minimum spend 0.02 ether
        minimumBuy = 20000000000000000; 

        // presale price 50 tokens per ether
        tokensPerEth = 50000000000000000000; 

        // airdrop balance, 5m
        airdropBalance = 5000000000000000000000000; 

        // presale balance, 5m  
        presaleBalance = 5000000000000000000000000; 

        // Put tokens inside contract
        balances[this] = totalSupply;
        emit Transfer(this, this, totalSupply);
    }

    // Events
    /////////////////////////////////////////////////////////
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event TokensPerEthUpdated(uint _tokensPerEth);
    event Burn(address indexed burner, uint256 value);
    
    // Only owner - use this to restrict functions 
    /////////////////////////////////////////////////////////
        modifier onlyOwner()
        {
          require(msg.sender == owner);
          _;
        }    
    
    // Transfer ownership - can be used to 'renounce'
    /////////////////////////////////////////////////////////
        function transferOwnership(address newOwner) onlyOwner public 
        {
            if (newOwner != address(0)) 
            {
               owner = newOwner;
            }
        }

    // Airdrop - use with Blockscan or custom solution
    /////////////////////////////////////////////////////////
        function Airdrop(address[] dests) onlyOwner external
        {
            uint256 i = 0;
            uint256 toSend = 10 * 10**18;
            while (i < dests.length && airdropBalance >= toSend) 
            {
               balances[this] = balances[this].sub(toSend);
               airdropBalance.sub(toSend);

               balances[dests[i]] = balances[dests[i]].add(toSend);

               emit Transfer(address(this), dests[i], toSend);

               i++;
            }
        }

    // When ethers are received, call the getTokens(); function
    /////////////////////////////////////////////////////////
        function () external payable 
        {
            getTokens();
        }

    // Get presale tokens
    /////////////////////////////////////////////////////////
        function getTokens() payable public 
        {
            uint256 tokens = 0; // initialise to zero
            tokens = tokensPerEth.mul(msg.value) / 1 ether; // calculate purchased amount        

            if (tokens > 0 && msg.value >= minimumBuy)
            {
               if (presaleBalance >= tokens)
               {
                  balances[this] = balances[this].sub(tokens);
                  presaleBalance.sub(tokens);

                  balances[msg.sender] = balances[msg.sender].add(tokens);

                  emit Transfer(address(this), msg.sender, tokens);
                  
                  owner.transfer(msg.value);        
               }
               else
               {   
                  // if thhere aren't enough tokens, refund user
                  msg.sender.transfer(msg.value);        
               }
            }
        }

    // Check owner balance
    // This is superfluous as this contract stores the tokens inside itself.
    // We keep it in as certain dApps look for this function in contracts.
    /////////////////////////////////////////////////////////
        function balanceOf(address _owner) public view returns (uint256) 
        {
            return balances[_owner];
        }

    // transfer tokens
    /////////////////////////////////////////////////////////
        modifier onlyPayloadSize(uint size) 
        {
            assert(msg.data.length >= size + 4);
            _;
        }
    
    function transfer(address _to, uint256 _amount) onlyPayloadSize(2 * 32) public returns (bool success) 
    {
        require(_to != address(0));
        require(_amount <= balances[msg.sender]);
        
        balances[msg.sender] = balances[msg.sender].sub(_amount);
        balances[_to] = balances[_to].add(_amount);
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }
    
    // transfer tokens between two parties
    /////////////////////////////////////////////////////////
        function transferFrom(address _from, address _to, uint256 _amount) onlyPayloadSize(3 * 32) public returns (bool success) 
        {
            require(_to != address(0));
            require(_amount <= balances[_from]);
            require(_amount <= allowed[_from][msg.sender]);
            
            balances[_from] = balances[_from].sub(_amount);
            allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_amount);
            balances[_to] = balances[_to].add(_amount);
            emit Transfer(_from, _to, _amount);
            return true;
        }

    // Approve token for trading on DEXes
    /////////////////////////////////////////////////////////
    function approve(address _spender, uint256 _value) public returns (bool success) 
    {
        if (_value != 0 && allowed[msg.sender][_spender] != 0) 
        { 
            return false;
        }

        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function allowance(address _owner, address _spender) constant public returns (uint256) 
    {
        return allowed[_owner][_spender];
    }
}
