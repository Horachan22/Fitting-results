classdef elements
    % 回路の各種パラメータ
    properties
        E;       % 電源電圧[V]
        R;       % 抵抗値[Ω]
        L;       % リアクタンス[mH]
        r;       % インダクタ内部抵抗[Ω]
        C;       % キャパシタンス[nF]
        f_RL_R;  % RL直列回路のV_Rの理論式
        f_RL_L;  % RL直列回路のV_Lの理論式
        f_RC_R;  % RC直列回路のV_Rの理論式
        f_RC_C;  % RC直列回路のV_Cの理論式
        f_RLC_R; % RLC直列回路のV_Rの理論式
        f_RLC_L; % RLC直列回路のV_Lの理論式
        f_RLC_C; % RLC直列回路のV_Cの理論式
    end
    
    methods
        function obj = elements(E, R, L, r, C)
            obj.E       = E;
            obj.R       = R;
            obj.L       = L * 10^(-3);
            obj.r       = r;
            obj.C       = C * 10^(-9);
            obj.f_RL_R  = @(x, t) x(1) * (1 - exp(-(t / x(2))));
            obj.f_RL_L  = @(x, t) x(1) * exp(-t * x(2));
            obj.f_RC_R  = @(x, t) x(1) * exp(-t / x(2));
            obj.f_RC_C  = @(x, t) x(1) * (1 - exp(-t / (x(2))));
            obj.f_RLC_R ;
            obj.f_RLC_L ;
            obj.f_RLC_C ;
        end
    end
end

