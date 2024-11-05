--偷偷作弊 抽卡
local this,id,ofs=GetID()
function this.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(this.cost)
	e1:SetOperation(this.activate)
	c:RegisterEffect(e1)
end
this.toss_coin=true
function this.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function this.activate(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.TossCoin(tp,1)
	if res==1 then Duel.Draw(tp,2,REASON_EFFECT)
	else
		local WIN_REASON=0xff
		Duel.Win(1-tp,WIN_REASON)
	end
end
