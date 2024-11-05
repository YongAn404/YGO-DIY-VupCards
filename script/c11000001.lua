--偷偷作弊 裤裆藏龙
local this,id,ofs=GetID()
function this.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(this.cost1)
	e1:SetOperation(this.operation1)
	c:RegisterEffect(e1)
end
function this.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function this.operation1(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.TossCoin(tp,1)
	if res==1 then 
		local token=Duel.CreateToken(tp,62706865)
		Duel.SendtoHand(token,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,token)
		Duel.ShuffleHand(tp)
	else
		local WIN_REASON=0xff
		Duel.Win(1-tp,WIN_REASON)
	end
end
