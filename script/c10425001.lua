---@diagnostic disable: undefined-global
--憨憨铃仙
function c12340000.initial_effect(c)
    local e11=Effect.CreateEffect(c)
    e11:SetDescription(aux.Stringid(12340000,0))
    e11:SetCategory(CATEGORY_DRAW)
    e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e11:SetCountLimit(1,12340000)
	e11:SetCode(EVENT_SUMMON_SUCCESS)
    e11:SetCost(c12340000.cost1)
    e11:SetOperation(c12340000.operation1)
	c:RegisterEffect(e11)

    local e12 = e11:Clone()
    e12:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e12)
    --[[
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(100000000,1))
    e2:SetCategory(CATEGORY_DRAW)
    e2:SetCountLimit(1,100000001)
    e2:SetRange(LOCATION_ONFIELD)
    e2:SetCondition(cxxxxx.condition2)
    e2:SetOperation(cxxxxx.operation2)--]]
end
function c12340000.filter1(c)
    return c:IsSetCard(0x999) and c:IsAbleToHand()
end

function c12340000.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,2,nil)
    end
    Duel.DiscardHand(tp,Card.IsDiscardable,2,2,REASON_COST+REASON_DISCARD)
end

function c12340000.operation1(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c12340000.filter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
        Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,ct)
	end
end
