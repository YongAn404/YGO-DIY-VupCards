--Test铃仙
local this,id,ofs=GetID()
function this.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,this.matfilter,2,2)
	c:EnableReviveLimit()
end
function this.matfilter(c)
	return c:IsLinkSetCard(0x998) and not c:IsLinkType(TYPE_LINK)
end