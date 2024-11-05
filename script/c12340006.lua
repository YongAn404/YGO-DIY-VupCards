--直播暂停
local this,id,ofs=GetID()
function this.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCountLimit(1,id)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(this.target1)
	e1:SetOperation(this.operation1)
	c:RegisterEffect(e1)
end
function this.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return  Card.IsAttackPos(chkc) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAttackPos,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.SelectTarget(tp,Card.IsAttackPos,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,tp,0)
end
function this.operation1(e,tp,eg,ep,ev,re,r,rp)
	local tc= Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
	end
end
