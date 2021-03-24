all: CONTRIBUTORS.md serve

install:
	npm i --save-dev docsify-cli
	./node_modules/docsify-cli/bin/docsify init ./
	./node_modules/docsify-cli/bin/docsify serve ./

serve:
	./node_modules/docsify-cli/bin/docsify serve ./

CONTRIBUTORS.md: fetch_contribs
	cp $@ $@.tmp
	cat $@.tmp | awk '/<!-- start_contributors -->/{p=1;print; system("cat /tmp/contribs");}/<!-- end_contributors -->/{p=0}!p' > $@
	rm -f $@.tmp /tmp/contribs

.PHONY: fetch_contribs
fetch_contribs:
	curl -s https://api.github.com/repos/ponsfrilus/Awesome-TPI/contributors | jq -r '.[] | "  * [@\(.login)](\(.html_url))"' > /tmp/contribs
