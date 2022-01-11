Integrated token, presale & airdrop contract.

How it works:

   ## The Presale Function

   The token sale function works like this:

   1: If you have not yet set up and deployed the contract, 
         get Remix IDE (https://remix-project.org) and start here:
        
         Set the following parameters in the Constructor (Use CTRL-F to find it)
      
         Change the defaults below to values of your choice

         // token ticker - keep it short, I stay max 5 chars
         symbol = "TKN"; 

         // token name - again, don't write a novel here. I go 10-15 chars or so.
         // a web address fits if it is short.
         name = "TOKEN"; 

         // how many decimals to allow
         decimals = 18; 

         // 10m total (in wei)
         totalSupply = 10000000000000000000000000; 

         // minimum spend 0.02 ether (in wei)
         minimumBuy = 20000000000000000; 

         // presale price 50 tokens per ether (in wei)
         tokensPerEth = 50000000000000000000; 

         // airdrop balance, 5m (in wei)
         airdropBalance = 5000000000000000000000000; 

         // presale balance, 5m (in wei)
         presaleBalance = 5000000000000000000000000; 

         When you are happy with your parameters, deploy the contract.



   2: Presale is live immediately upon deployment; 
         you can of course add a simply toggle function, 
         but I havent; I'm not your mum, do some stuff yourself.

         Anyway...

         The buyer sends any amount of ether to the Contract address
         and the corresponding amount of tokens is remitted.
        
         The ethereum (or matic, or bnb, or ftm etc) is remitted to the Owner Wallet.
        
         The Owner Wallet is the address used to deploy the contract.

         Pretty simple, yes?



   3: Over to you; put it on an exchange, add liquidity, do whatever.



   ## The Airdrop Function
      Before you start, go check the airdropAmount; 
      It is currently set to 10 tokens and you can change this.

      There are two ways you can use this:

   1: From BlockScan (etherscan, bscscan etc)

         Verify your contract on the site.

         Go to the "Write Contract" page and look for

         "Batch Airdrop"

         (to use this you will need a Metamask wallet, google it)

         Anyway...

         Paste in a Comma Separated array of 0x addresses

         Click "Write" and complete the transaction in Metamask.


   2: From a web3.js or equivalent script
        
         That's a whole n'other script in and of itself. 
         I have made something, an Airdrop Tool, but it is not yet ready for human consumption.
          
         If I upload it, it'll be in this bit.  In the mean time, google it.
        
        
   ## terms and conditions apply; if you use this and incur loss, hard cheese.  
   ## No warranty is provided and there is no customer care telphone number.
   ## A nice lady called Sue is not ready to assist you.
   
   // fin
