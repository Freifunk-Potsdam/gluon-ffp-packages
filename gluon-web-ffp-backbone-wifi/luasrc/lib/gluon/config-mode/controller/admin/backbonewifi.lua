local uci = require("simple-uci").cursor()
local wireless = require 'gluon.wireless'

package 'gluon-web-ffp-backbone-wifi'

if wireless.device_uses_wlan(uci) then
	entry({"admin", "backbonewifi"}, model("admin/backbonewifi"), _("Backbone WLAN"), 29)
end
