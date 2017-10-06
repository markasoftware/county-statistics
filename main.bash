#!/bin/bash

[[ -e usc_a-c.html ]] || wget http://ng3k.com/Misc/usc_{a-c,d-h,i-k,l-m,n,o-r,s-u,v-w}.html
cat *.html | grep '<li>' | grep County | grep -v '</a>' | sed -r 's/(\s*<.?li>\s*)|(\([A-Z]+\))|County|Area//g' | tee all_counties.txt
