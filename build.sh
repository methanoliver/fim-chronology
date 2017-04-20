#!/bin/bash

sed -ie 's|</script>|<\\u002fscript>|g' dist/static/main.min.js
sed -ie 's|</html>|<\\u002fhtml>|g' dist/static/main.min.js 
mkdir -p build
inliner -m --nosvg --skip-absolute-urls dist/index.html > build/index.html
