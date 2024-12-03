--VUP 管理中心・强制审核终止
local this,id,ofs=GetID()
function this.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)

	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_REMOVE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x999))
	c:RegisterEffect(e1)

	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetCost(this.cost2)
	e2:SetOperation(this.operation2)
	c:RegisterEffect(e2)

	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetOperation(this.operation3)
	c:RegisterEffect(e3)
end

function this.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return true end
    if chk==0 then return chk:IsSetCard(0x999) end
end

function this.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,0,LOCATION_HAND,1,e:GetHandler(),POS_FACEDOWN) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemoveAsCost,tp,0,LOCATION_HAND,1,1,nil,POS_FACEDOWN)
	Duel.Remove(g,POS_FACEDOWN,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,0,1-tp,LOCATION_REMOVED)
end
function this.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(1-tp,Card.IsAbleToDeck,1-tp,LOCATION_REMOVED,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,1-tp,0,REASON_EFFECT)
	end
end
function this.filter3(c,tp)
    return c:IsSetCard(0x999) and c:IsAbleToRemove(tp,POS_FACEUP,REASON_EFFECT)
end
function this.cost3(e,tp,eg,ep,ev,re,r,rp)
	if chk==0 then return Duel.IsExistingMatchingCard(this.filter3,tp,0,LOCATION_ONFIELD,1,e:GetHandler(),tp) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,0,tp,LOCATION_ONFIELD)
end
function this.operation3(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(this.filter3,tp,LOCATION_ONFIELD,0,nil,tp)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end