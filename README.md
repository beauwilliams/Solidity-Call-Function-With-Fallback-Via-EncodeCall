#  Solidity-Call-Function-With-Fallback-Via-EncodeWithSignature
## OVERVIEW

We will examine `call()` which is a solidity builtin function that allows us to call functions in other smart contracts. Here we will show how to call from a caller contract, what happens when function does and does not exist in the receiver contract.

## Contract


![carbon (21)](https://user-images.githubusercontent.com/7098556/193192519-d073638e-1598-480b-8397-455840db4c18.png)


## Test


![carbon (23)](https://user-images.githubusercontent.com/7098556/193197240-f162962a-e4d7-4fdd-b4ca-03761408cd5a.png)


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
