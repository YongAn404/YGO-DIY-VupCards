--VUP·雪片蓮
local this,id,ofs=GetID()
function this.initial_effect(c)
    --negate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCondition(this.condition1)
	e1:SetCost(this.cost1)
	e1:SetTarget(this.target1)
	e1:SetOperation(this.operation1)
	c:RegisterEffect(e1)
end

function this.condition1(e,tp,eg,ep,ev,re,r,rp)
	local ex2,g2,gc2,dp2,dv2=Duel.GetOperationInfo(ev,CATEGORY_SPECIAL_SUMMON)
	return ((ex2 and bit.band(dv2,LOCATION_DECK)==LOCATION_DECK)) and Duel.IsChainDisablable(ev)
end
function this.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function this.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
    if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
        Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
    end
end
function this.operation1(e,tp,eg,ep,ev,re,r,rp)
    if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
        Duel.Destroy(eg,REASON_EFFECT)
		
		local c=e:GetHandler()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_DELAY)
		e1:SetCode(EVENT_SPSUMMON_SUCCESS)
		e1:SetCondition(this.drcon1)
		e1:SetOperation(this.drop1)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		--sp_summon effect
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e2:SetCode(EVENT_SPSUMMON_SUCCESS)
		e2:SetCondition(this.regcon)
		e2:SetOperation(this.regop)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e3:SetCode(EVENT_CHAIN_SOLVED)
		e3:SetCondition(this.drcon2)
		e3:SetOperation(this.drop2)
		e3:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e3,tp)
    end
end

function this.filter(c,sp)
	return c:IsSummonPlayer(sp)
end
function this.drcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(this.filter,1,nil,1-tp)
		and (not re:IsHasType(EFFECT_TYPE_ACTIONS) or re:IsHasType(EFFECT_TYPE_CONTINUOUS))
end
function this.drop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
end
function this.regcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(this.filter,1,nil,1-tp)
		and re:IsHasType(EFFECT_TYPE_ACTIONS) and not re:IsHasType(EFFECT_TYPE_CONTINUOUS)
end
function this.regop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(tp,id,RESET_CHAIN,0,1)
end
function this.drcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,id)>0
end
function this.drop2(e,tp,eg,ep,ev,re,r,rp)
	local n=Duel.GetFlagEffect(tp,id)
	Duel.ResetFlagEffect(tp,id)
	Duel.Draw(tp,n,REASON_EFFECT)
end

