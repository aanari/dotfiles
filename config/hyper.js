module.exports = {

    config: {
        webGLRenderer: false,

        fontSize: 12,

        fontFamily: '"FuraCode Nerd Font"',

        fontWeight: 'normal',

        updateChannel: 'canary',

        backgroundColor: '#002b36',

        foregroundColor: '#839496',

        cursorShape: 'BLOCK',

        cursorBlink: true,

        titleBarStyle: 'hidden',

        cursorColor: 'rgba(131, 148, 150, 0.5)',

        selectionColor: 'rgba(7, 54, 66, 0.5)',

        borderColor: 'transparent',

        showHamburgerMenu: true,

        showWindowControls: true,

        padding: '2px 2px 0px 2px',

        shell: '',

        shellArgs: ['--login'],

        scrollback: 10000,

        env: {},

        bell: false,

        copyOnSelect: true,

        defaultSSHApp: true,

        quickEdit: false,

        macOptionSelectionMode: 'vertical',

        css: 'div.xterm-screen, canvas { width: 100% !important }',

        termCSS: '::-webkit-scrollbar { display: none; }',

        opacity: {
            focus: 1,
            blur: 0.96
        },

        colors: {
            lightBlack: '#002b36',
            black: '#073642',
            lightGreen: '#859900',
            lightYellow: '#b58900',
            lightBlue: '#268bd2',
            lightCyan: '#2aa198',
            white: '#eee8d5',
            lightWhite: '#fdf6e3',
            yellow: '#b58900',
            lightRed: '#cb4b16',
            red: '#d30102',
            magenta: '#d33682',
            lightMagenta: '#6c71c4',
            blue: '#268bd2',
            cyan: '#2aa198',
            green: '#859900'
        }
    },

    plugins: [
        "hyperlinks",
        "hyper-blink",
        "hyper-font-ligatures",
        "hyperterm-paste",
        "hyper-pane",
        "hyperminimal",
        "hyper-font-smoothing",
        "hyper-opacity"
    ],

    localPlugins: []
};
