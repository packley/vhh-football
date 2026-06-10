#!/bin/bash
# Swap the voice clips in Very Hard Hitting Football.
# Usage: ./update-voices.sh <doodly.mp3> <yowz.mp3>
# Any mp3 works (ElevenLabs download, a recording of yourself, whatever).
set -e
cd "$(dirname "$0")"
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "usage: ./update-voices.sh <doodly.mp3> <yowz.mp3>"; exit 1
fi
python3 - "$1" "$2" <<'EOF'
import base64, re, sys
s=open('index.html').read()
d=base64.b64encode(open(sys.argv[1],'rb').read()).decode()
y=base64.b64encode(open(sys.argv[2],'rb').read()).decode()
s=re.sub(r"doodly:'[A-Za-z0-9+/=]+'", "doodly:'"+d+"'", s, count=1)
s=re.sub(r"yowz:'[A-Za-z0-9+/=]+'", "yowz:'"+y+"'", s, count=1)
open('index.html','w').write(s)
print('done: doodly %dKB, yowz %dKB embedded into index.html'%(len(d)//1024,len(y)//1024))
EOF
echo "Refresh the game to hear them."
