# Linting SASS

## Requirements
- `sass-lint`
- `sass-lint-auto-fix`


## Setup

### Install requirements
```bash
npm i sass-lint sass-lint-auto-fix
```

### Create configuration file
- You can use JSON / YAML or RC file. There is no difference.
```bash
touch .sasslintrc.json
```
- Specify the correct path to your `.sasslintrc.json` in `package.json` by adding:
```json
"sasslintConfig": ".sasslintrc.json"
```

### Example configuration
```json
{
  "files": {
    "include": "src/sass/*.sass",
    "ignore": [
      "node_modules/**"
    ]
  },
  "rules": {
    "property-sort-order": [
      1,
      {
        "order": "smacss"
      }
    ],
    "class-name-format": [
      1,
      {
        "convention": "hyphenatedbem"
      }
    ],
    "no-color-literals": 0,
    "nesting-depth": [
      1,
      {
        "max-depth": 5
      }
    ],
    "no-qualifying-elements": [
      1,
      {
        "allow-element-with-attribute": true
      }
    ],
    "force-pseudo-nesting": 0
  }
}
```

### Create npm commands to run lint
```json
"lint": "sass-lint -v",
"lint:fix": "sass-lint-auto-fix"
```
So now you can run:
- `npm run lint` to get list of issues/warning in your `.sass` files
- `npm run lint:fix` to fix some of them automatically

### Linting on hooks
Most common usecase is `pre-commit` or `pre-push` hooks. So you will run `lint:fix` and `lint` automatically when enter `git commit` or `git push`.

For that purpose you can use - `Husky`.
```bash
npm i husky
```

Then configure `Husky` hooks in your `package.json`:
```json
"husky": {
    "hooks": {
      "pre-commit": "npm run lint:fix && npm run lint",
      "pre-push": "npm run lint:fix && npm run lint"
    }
  }
```

## References
- [Rules explanation](https://github.com/sasstools/sass-lint/tree/develop/docs/rules)
- [sass-lint](https://github.com/sasstools/sass-lint)
- [sass-lint-auto-fix](https://github.com/srowhani/sass-lint-auto-fix)
- [husky](https://github.com/typicode/husky)

