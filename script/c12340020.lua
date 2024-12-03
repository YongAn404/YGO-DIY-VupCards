--VUP·绪方白
local this,id,o=GetID()
function this.initial_effect(c)
    --special summon (self)
    local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCost(this.cost1)
	e1:SetOperation(this.operation1)
	c:RegisterEffect(e1)

    local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x999))
	e2:SetValue(1)
	c:RegisterEffect(e2)

    local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,id+1)
	e3:SetCost(this.cost3)
	e3:SetOperation(this.operation3)
	c:RegisterEffect(e3)
end
function this.filter11(c)
	return c:IsSetCard(0x999) and c:IsDiscardable()
end
function this.filter12(c)
	return c:IsSetCard(0x999) and c:IsAbleToHand()
end
function this.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(this.filter11,tp,LOCATION_HAND,0,1,e:GetHandler()) and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.DiscardHand(tp,this.filter11,1,1,REASON_EFFECT+REASON_DISCARD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,tp,LOCATION_HAND)
end

function this.operation1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
    if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP) then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
        local g=Duel.SelectMatchingCard(tp,this.filter12,tp,LOCATION_DECK,0,1,1,nil)
        if g:GetCount()>0 then
            Duel.SendtoHand(g,nil,REASON_EFFECT)
            Duel.ConfirmCards(1-tp,g)
            Duel.ShuffleHand(tp)
        end
    end
end
function this.cost3(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(this.filter12,tp,LOCATION_GRAVE,0,1,nil) and Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil)
    end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_GRAVE)
end
function this.operation3(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    local g=Duel.SelectMatchingCard(tp,this.filter12,tp,LOCATION_GRAVE,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.HintSelection(g)
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
		Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_EFFECT+REASON_DISCARD)
        Duel.ShuffleHand(tp)
    end
end