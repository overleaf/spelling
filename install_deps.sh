# some spelling packages are missing from debian and are on ubuntulo
# echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic main universe" >> /etc/apt/sources.list
# apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
apt-get update
# apt-get install -y aspell aspell-en aspell-af aspell-am aspell-ar aspell-ar-large aspell-bg aspell-bn aspell-br aspell-ca aspell-cs aspell-cy aspell-da aspell-de aspell-de-alt aspell-el aspell-eo aspell-es aspell-et aspell-eu-es aspell-fa aspell-fo aspell-fr aspell-ga aspell-gl-minimos aspell-gu aspell-he aspell-hi aspell-hr aspell-hsb aspell-hu aspell-hy aspell-id aspell-is aspell-it aspell-kk aspell-kn aspell-ku aspell-lt aspell-lv aspell-ml aspell-mr aspell-nl aspell-no aspell-nr aspell-ns aspell-or aspell-pa aspell-pl aspell-pt aspell-pt-br aspell-ro aspell-ru aspell-sk aspell-sk aspell-ss aspell-st aspell-sv aspell-ta aspell-te aspell-tl aspell-tn aspell-ts aspell-uk aspell-uz aspell-xh aspell-zu
apt install -y hunspell hunspell-af hunspell-an hunspell-ar hunspell-be hunspell-bg \
 hunspell-bn hunspell-br hunspell-bs hunspell-ca hunspell-cs hunspell-da \
 hunspell-de-at hunspell-de-ch \
 hunspell-de-de hunspell-el hunspell-en-au \
 hunspell-en-ca hunspell-en-gb hunspell-en-us hunspell-en-za hunspell-es \
 hunspell-eu hunspell-fr hunspell-gd hunspell-gl \
 hunspell-gu hunspell-he hunspell-hi hunspell-hr \
 hunspell-hu hunspell-is hunspell-it hunspell-kk hunspell-kmr hunspell-ko \
 hunspell-lo hunspell-lt hunspell-ml hunspell-ne hunspell-no hunspell-oc \
 hunspell-pl hunspell-pt-br hunspell-pt-pt hunspell-ro hunspell-ru \
 hunspell-se hunspell-si hunspell-sk hunspell-sl hunspell-sr hunspell-sv \
 hunspell-sw hunspell-te hunspell-th hunspell-uk hunspell-uz hunspell-vi \
 hunspell-bo \
 hunspell-nl hunspell-de-med hunspell-en-med
mkdir /app/cache
chown node:node /app/cache
chmod 0777 /app/cache