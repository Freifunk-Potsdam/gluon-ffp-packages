mt7915 hotfix
=============

This script reloads mt7915-firmware twice a day on targets ramips-mt7621
and mediatek-filogic. It's meant as a hotfix for the mcu timeout issue:
https://github.com/freifunk-gluon/gluon/issues/3154
The issue popped up with Gluon v2023.2, earlier releases are not affected.

v1 is currently just a workaround
v2 might become an actual hotfix hence the name

A first idea for a hotfix was proposed by blocktrron:
https://github.com/freifunk-gluon/gluon/pull/3212

Create a file `modules` with the following content in your `./gluon/site/`
directory and add these lines: 

```
GLUON_SITE_FEEDS="community"
PACKAGES_COMMUNITY_REPO=https://github.com/freifunk-gluon/community-packages.git
PACKAGES_COMMUNITY_COMMIT=*/missing/*
PACKAGES_COMMUNITY_BRANCH=master
```

Now you can add the package `ffac-mt7915-hotfix` to your site.mk
(`*/missing/*` has to be replaced by the github-commit-ID of the version you
want to use, you have to pick it manually.)

Further info on the issue this tries to prevent from happening:
I've seen the MCU timeout issue happening as early as 16 hours of uptime.
MCU timeouts result in WiFi not working. WiFi mesh nodes running into the
issue go offline until they are rebooted manually while any wired node is
still accessible via ssh.

On most devices it will take days or weeks for this issue to manifest,
while others are affected daily. This is due to the difference in clients
that are connecting to it on a frequent base. The more people frequent
the device the more it goes offline.
Twice a day might seem exaggerated to some but the it's fast so why not.
I want to minimize downtime and therefore reload wifi right before heavy
use. Once for sunrise (daytime) and and once before dawn (when bars open).

It's not clear whether this fix is required on mediatek-filogic.
Freifunk Aachen is only testing it on ramips-mt7621 currently.
mediatek-filogic is unstable enough that I suggest rebooting the target
3 times a day. See package [ffac-threetime-reboot](https://github.com/freifunk-gluon/community-packages/tree/master/ffac-threetime-reboot)
