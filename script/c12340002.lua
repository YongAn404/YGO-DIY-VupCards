--事故铃仙
local this,id,ofs=GetID()
function this.initial_effect(c)
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e1:SetCountLimit(1,id)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCost(this.cost1)
    e1:SetOperation(this.operation1)
	c:RegisterEffect(e1)

    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_QUICK_F)
    e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_TO_GRAVE)
    e2:SetCountLimit(1,id+1)
    e2:SetCost(this.cost2)
    e2:SetOperation(this.operation2)
	c:RegisterEffect(e2)
end

function this.filter11(c)
	return c:IsCode(12340004) and c:IsAbleToHand()
end
function this.filter12(c)
	return c:IsCode(12340006) and c:IsAbleToHand()
end

function this.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and (Duel.IsExistingMatchingCard(this.filter11,tp,LOCATION_DECK,0,1,nil)
        or Duel.IsExistingMatchingCard(this.filter12,tp,LOCATION_DECK,0,1,nil))
    end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end

function this.operation1(e,tp,eg,ep,ev,re,r,rp)
    local g = Duel.GetMatchingGroup(this.filter11,tp,LOCATION_DECK,0,nil)
    if g:GetCount()>0 then
        g = g:GetFirst()
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
	end
    g = Duel.GetMatchingGroup(this.filter12,tp,LOCATION_DECK,0,nil)
    if g:GetCount()>0 then
        g = g:GetFirst()
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
	end
end
function this.filter2(c,e,tp)
    return c:IsCode(12340005) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function this.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        return Duel.IsExistingMatchingCard(this.filter2,tp,LOCATION_DECK,0,1,nil,e,tp)
         or Duel.IsExistingMatchingCard(this.filter2,tp,LOCATION_HAND,0,1,nil,e,tp)
         and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
    end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function this.operation2(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    local g=Duel.SelectMatchingCard(tp,this.filter2,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
    if g:GetCount()>0 then
        Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
        Duel.ConfirmCards(1-tp,g)
        Duel.ShuffleHand(tp)
    end
end
