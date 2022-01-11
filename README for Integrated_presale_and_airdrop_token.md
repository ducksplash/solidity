Integrated token, presale & airdrop contract

How this works:

    ## The Presale Function

    The token sale function works like this:

      1: You set the following parameters in the constructor below (Use CTRL-F dude)

          tokensPerEth (in wei, use a converter or add maths yourself)
          minimumBuy (in wei) 
          presaleBalance (in wei)

        These parameters are currently set to:

        50 tokens per 1 eth (or bnb, or matic, or ftm....)

        0.02 eth minimum buy.

        5m tokens in presale balance.

        When you are happy with your parameters, deploy the contract.



      2: Presale is live immediately upon deployment; 
      you can of course add a simply toggle function, 
      but I havent; I'm not your mum, do some stuff yourself.

          Anyway...

          The buyer sends any amount of ether to the Contract address
          and the corresponding amount of tokens is remitted.

          Pretty simple, yes?


      3: Over to you; put it on an exchange, add liquidity, do whatever.



      ## The Airdrop Function
      - Before you start, go check the 

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
