# renaissance-underscore-template

[![Test Status](https://github.com/frncsdrk/renaissance-underscore-template/workflows/test/badge.svg?branch)](https://github.com/frncsdrk/renaissance-underscore-template/actions)

renaissance adapter to use underscore templates

## Usage

```js
const { r } = require('renaissance')
const UnderscoreTemplateAdapter = require('renaissance-underscore-template')
const adapter = r.registerAdapter('underscoreTemplate', UnderscoreTemplateAdapter)

adapter.tmpl('foo', 'bar');
console.log(lsa.get('foo'));
```

## API

### adapter.tmpl({string} text, {object} data)

Create a template

## Contributing

See [CONTRIBUTING](https://github.com/frncsdrk/renaissance-underscore-template/blob/master/CONTRIBUTING.md)

## Credits

See [CREDITS](https://github.com/frncsdrk/renaissance-underscore-template/blob/master/CREDITS)

## License

[MIT](https://github.com/frncsdrk/renaissance-underscore-template/blob/master/LICENSE) (c) 2017 - 2021 frncsdrk and contributors
