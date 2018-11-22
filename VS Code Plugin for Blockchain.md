# VS Code Plugins for Blockchain

- Vim Syntastic [vim-syntastic](https://github.com/vim-syntastic/syntastic)
- Solidity  Juan Blanco [visualstudio Solidity](https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity)
- solidity-solhint ilya.drabenia [solidity-solhint](https://marketplace.visualstudio.com/items?itemName=idrabenia.solidity-solhint)

# Npm 
- npm install -g solium [Solium](https://github.com/duaraghav8/Solium)
- solium init
- npm install -g solhint [solhint](https://github.com/protofire/solhint)
- npm install -g solium-plugin-consensys []()
- [list-of-style-rules for solium](http://solium.readthedocs.io/en/latest/user-guide.html#list-of-style-rules)


# .soliumrc.json
  `{
    "extends": "solium:recommended",
    "plugins": ["security"],
    "rules": {
      "quotes": 0,
      "indentation": ["error", 4]
    }
  }`


# Vs Code Settings
```JavaScript
{
    "editor.dragAndDrop": false,
    "editor.fontSize": 12,
    "editor.formatOnSave": true,
    "editor.formatOnType": true,
    "editor.formatOnPaste": true,
    "editor.wordWrap": "on",
    "editor.quickSuggestions": {
        "other": true,
        "comments": true,
        "strings": true
    },
    "explorer.confirmDragAndDrop": false,
    "explorer.confirmDelete": false,
    "files.autoSave": "onFocusChange",
    "workbench.colorTheme": "Default Light+",
    "solidity.enabledAsYouTypeCompilationErrorCheck": true,
    "solidity.linter": "solium",
    "solidity.packageDefaultDependenciesContractsDirectory": "",
    "solidity.packageDefaultDependenciesDirectory": "",
    "solidity.validationDelay": 1500
}
```

