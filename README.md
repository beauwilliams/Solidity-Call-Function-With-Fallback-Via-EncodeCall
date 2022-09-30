#  Solidity-Call-Function-With-Fallback-Via-EncodeCall
## OVERVIEW

We will examine `call()` which is a solidity builtin function that allows us to call functions in other smart contracts. Here we will show how to call from a caller contract, what happens when function does and does not exist in the receiver contract.


![carbon99](https://user-images.githubusercontent.com/7098556/193188251-96656606-85a4-4f33-aa20-14e453fe26b1.png)


## GET STARTED

This project uses a [task runner called just, for convenience](https://github.com/casey/just)

```
Available recipes:
    default
    install *PACKAGES
    update
    compile
    deploy-localhost
    deploy-testnet
    verify-testnet
    test
    lint
    start
    format
    audit
    print-audit
    print-gas-usage
    print-deployments
    clean
```

### Running tests and audits

- Run the unit tests with `just test`
- Statically analyse code for vulnerabilities with `just audit` 
