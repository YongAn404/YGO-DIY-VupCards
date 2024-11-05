local this,id,ofs=GetID()
function this.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCost(this.cost1)
	e1:SetOperation(this.operation1)
	c:RegisterEffect(e1)
end
function this.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,LOCATION_HAND,1,nil) end
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,LOCATION_HAND,1,1,nil)
	e:SetLabelObject(g:GetFirst())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,tp,0)
end
function this.operation1(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local token=Duel.CreateToken(tp,tc:GetCode())
	Duel.SendtoHand(token,nil,REASON_EFFECT)
    Duel.ConfirmCards(1-tp,token)
    Duel.ShuffleHand(tp)
end
