--憨憨铃仙
local this,id,ofs=GetID()
function this.initial_effect(c)
    local e11=Effect.CreateEffect(c)
    e11:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
    e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e11:SetCountLimit(1,id)
	e11:SetCode(EVENT_SUMMON_SUCCESS)
    e11:SetCost(this.cost1)
    e11:SetOperation(this.operation1)
	c:RegisterEffect(e11)

    local e12 = e11:Clone()
    e12:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e12)

    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DESTROYED)
    e2:SetCondition(this.condition2)
    e2:SetCost(this.cost2)
	e2:SetOperation(this.operation2)
	c:RegisterEffect(e2)
end
function this.filter1(c)
    return c:IsSetCard(0x999) and c:IsAbleToHand()
end
function this.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil)
        and Duel.IsExistingMatchingCard(this.filter1,tp,LOCATION_DECK,0,1,nil)
        and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
    end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function this.operation1(e,tp,eg,ep,ev,re,r,rp)
    if Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_EFFECT+REASON_DISCARD)<=0 then return end
    local g=Duel.SelectMatchingCard(tp,this.filter1,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.HintSelection(g)
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
        Duel.ShuffleHand(tp)
    end
end

function this.filter2(c)
    return c:IsCode(12339998) and c:IsAbleToHand()
end
function this.condition2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_EFFECT)
end
function this.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        return Duel.IsExistingMatchingCard(this.filter2,tp,LOCATION_DECK,0,1,nil)
    end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function this.operation2(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.SelectMatchingCard(tp,this.filter2,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.HintSelection(g)
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
        Duel.ShuffleHand(tp)
    end
end
