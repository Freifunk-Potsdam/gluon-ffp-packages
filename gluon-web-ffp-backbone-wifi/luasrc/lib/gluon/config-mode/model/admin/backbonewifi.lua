local iwinfo = require 'iwinfo'
local uci = require("simple-uci").cursor()
local wireless = require 'gluon.wireless'
local site = require 'gluon.site'
local hash = require 'hash'
local pretty_hostname = require 'pretty_hostname'

-- where to read the configuration from
local radio_name = 'radio0'
local bbcl_iface = 'bbcl_' .. radio_name
local bbap_iface = 'bbap_' .. radio_name

local radio = uci:get_all('wireless',radio_name)
local phy = wireless.find_phy( radio )
local ssid_list = iwinfo.nl80211.scanlist(phy)

local f = Form(translate("Backbone Wifi"))

local scl = f:section(Section, translate("Backbone Client"), translate(
	'Description of Backbone Client'
))

local bbcl_enabled = scl:option(Flag, "bbcl_enabled", translate("Enabled"))
bbcl_enabled.default = uci:get('wireless', bbcl_iface) and not uci:get_bool('wireless', bbcl_iface, "disabled")

local bbcl_ssid_l = scl:option(ListValue, "bbcl_ssid_l", translate("Remote SSID"))
bbcl_ssid_l:depends(bbcl_enabled, true)
bbcl_ssid_l:value("_", translate("Manual"))
bbcl_ssid_l.default = ""
for _,entry in pairs(ssid_list) do
        if entry.ssid and entry.ssid == "_" and entry.mode == 'Master' then
                bbcl_ssid_l:value(entry.ssid, string.format("%s [%s] (Ch: %d, S: %d, Q: %d)",entry.ssid, entry.bssid, entry.channel, entry.signal, entry.quality))
                if entry.ssid == uci:get('wireless', bbcl_iface, "ssid") then
                    bbcl_ssid_l.default = entry.ssid
                end
        end
end

local bbcl_ssid_s = scl:option(Value, "bbcl_ssid_s", translate("Remote SSID"))
bbcl_ssid_s:depends(bbcl_ssid_l, "_")
bbcl_ssid_s.datatype = "maxlength(32)"
bbcl_ssid_s.default = uci:get('wireless', bbcl_iface, "ssid")

local sap = f:section(Section, translate("Backbone AP"), translate(
	'Description of Backbone AP'
))

local bbap_enabled = sap:option(Flag, "bbap_enabled", translate("Enabled"))
bbap_enabled.default = uci:get('wireless', bbap_iface) and not uci:get_bool('wireless', bbap_iface, "disabled")

local bbap_ssid = sap:option(Value, "bbap_ssid", translate("AP SSID"))
bbap_ssid:depends(bbap_enabled, true)
bbap_ssid.datatype = "maxlength(32)"
local hostname = pretty_hostname.get(uci)
local prefix = "ffp-"
hostname = (hostname:sub(0, #prefix) == prefix) and hostname:sub(#prefix+1) or hostname
bbap_ssid.default = uci:get('wireless', bbap_iface, "ssid") or ("ffpbb-" .. hostname)

function f:write()
        if bbcl_enabled.data then
                local bbcl_macaddr = wireless.get_wlan_mac(uci, radio, 1, 2)
                uci:section('wireless', 'wifi-iface', bbcl_iface, {
                        device     = radio_name,
                        network    = 'mesh_bbcl',
                        mode       = 'sta',
                        encryption = 'psk2',
                        key        = site.wifi.bbffp_passphrase() or hash.md5(site.site_name()),
                        macaddr    = bbcl_macaddr,
                        ifname     = bbcl_iface,
                        disabled   = false,
                })
                if bbcl_ssid_l.data == "_" then
                    uci:set('wireless', bbcl_iface, "ssid", bbcl_ssid_s.data)
                else
                    uci:set('wireless', bbcl_iface, "ssid", bbcl_ssid_l.data)
                end
        else
                uci:set('wireless', bbcl_iface, "disabled", true)
        end
        if bbap_enabled.data then
                local bbap_macaddr = wireless.get_wlan_mac(uci, radio, 1, 6)
                uci:section('wireless', 'wifi-iface', bbap_iface, {
                        device     = radio_name,
                        network    = 'mesh_bbap',
                        mode       = 'ap',
                        ssid       = bbap_ssid.data,
                        encryption = 'psk2',
                        key        = site.wifi.bbffp_passphrase() or hash.md5(site.site_name()),
                        macaddr    = bbap_macaddr,
                        ifname     = bbap_iface,
                        isolate    = true,
                        disabled   = false,
                })
        else
                uci:set('wireless', bbap_iface, "disabled", true)
        end
	uci:commit('wireless')
end

return f
