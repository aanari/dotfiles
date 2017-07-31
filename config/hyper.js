module.exports = {

  config: {
    
    fontSize: 12,

    fontFamily: '"Meslo LG S DZ for Powerline", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

    cursorColor: 'rgba(101, 123, 131, 0.5)',

    cursorShape: 'BLOCK',

    cursorBlink: true,

    foregroundColor: '#657b83',

    backgroundColor: '#fdf6e3',

    borderColor: '#333',

    css: '',

    termCSS: '',

    showHamburgerMenu: false,

    showWindowControls: false,

    padding: '0px 4px',

    colors: {
      black: '#073642',
      red: '#dc322f',
      green: '#859900',
      yellow: '#b58900',
      blue: '#268bd2',
      magenta: '#d33682',
      cyan: '#2aa198',
      white: '#eee8d5',
      lightBlack: '#002b36',
      lightRed: '#cb4b16',
      lightGreen: '#586e75',
      lightYellow: '#657b83',
      lightBlue: '#839496',
      lightMagenta: '#6c71c4',
      lightCyan: '#93a1a1',
      lightWhite: '#fdf6e3'
    },

    shell: '',

    shellArgs: ['--login'],

    env: {},

    bell: 'SOUND',

    copyOnSelect: false,

    quickEdit: true

  },

  plugins: [
    "hyperfull",
    "hyperlinks"
  ],

  localPlugins: []

};
