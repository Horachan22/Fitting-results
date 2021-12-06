%% main
function fitting()
    file_name = "RC回路のCの波形.CSV";
    circuit   = elements(10, 1480, 3.98, 4.72, 97.7);
    
    % データの読み取り(データ点数 RC_R:2232, RC_C:1901, RL_L:1720, RL_R:2086)
    data_num = 1901;
    time     = transpose(read_csv_data(file_name, 0, data_num, 0, 0));
    exp_data = transpose(read_csv_data(file_name, 0, data_num, 1, 1));

    % 最小二乗法による近似
    approximate_data(time, exp_data, circuit.f_RC_C);

    %% RC回路のCの波形
    %{
    plot(time, exp_data);
    hold on;
    fplot(@(time) 68995 * time, [0, 0.0002], 'k');
    fplot(@(time) 10.0, [0, 0.0008], 'k');
    xline(0.1455 * 10^(-3));
    hold off;
    title("RC回路のCの波形");
    xlabel("時刻t");
    ylabel("電圧V_C");
    legend('実験値');
    %}

    %% RC回路のRの波形
    %{
    plot(time, exp_data);
    hold on;
    fplot(@(time) -68995 * time + 10, [0, 0.1455 * 10^(-3)], 'k');
    xlim([0 8.0 * 10^(-4)]);
    ylim([0 10]);
    hold off;
    title("RC回路のRの波形");
    xlabel("時刻t");
    ylabel("電圧V_R");
    legend('実験値');
    % tau_RC = 0.1455 * 10^(-3)
    %}

    %% RL回路のLの波形
    %{
    plot(time, exp_data);
    hold on;
    fplot(@(time) -3400000 * time + 10, [0, 0.1455 * 10^(-4)], 'k');
    xlim([0 3.5 * 10^(-5)]);
    ylim([0 10]);
    hold off;
    title("RL回路のLの波形");
    xlabel("時刻t");
    ylabel("電圧V_L");
    legend('実験値');
    %}

    %% RL回路のRの波形
    %{
    plot(time, exp_data);
    hold on;
    fplot(@(time) 3400000 * time, [0, 0.1455 * 10^(-4)], 'k');
    fplot(@(time) 9.7, [0, 0.0008], 'k');
    xline(2.87 * 10^(-6));
    xlim([0 2.0 * 10^(-5)]);
    ylim([0 10]);
    hold off;
    title("RL回路のLの波形");
    xlabel("時刻t");
    ylabel("電圧V_R");
    legend('実験値');
    % tau_RL = 2.87 * 10^(-6)
    %}

end

%% csvデータの読み取りを行う関数(R1:開始行、R2:終了行、C1:開始列、C2:終了列)
function read_data = read_csv_data(file_name, R1, R2, C1, C2)
    read_data = csvread(file_name, R1, C1, [R1, C1, R2, C2]);
    return
end

%% 最小二乗法で近似を行う関数
function approximate_data(x_data, y_data, func)
    x0    = [x_data(1901), y_data(1901)]; %(RLのR、RCのCのとき(end)、RLのL、RCのRのとき(1)を記入)
    para  = lsqcurvefit(func, x0, x_data, y_data); %para(1)は電圧、para(2)は時定数
    app_x = linspace(x_data(1), x_data(end), length(x_data));
    plot_graph(x_data, y_data, func, app_x, para);
end

%% グラフを描く関数
function plot_graph(x_data, y_data, func, app_x, para)
    plot(x_data, y_data, app_x, func(para, app_x))
    title("RL回路のLの波形");
    ylim([0 10]);
    xlabel("時刻t");
    ylabel("電圧E_L");
    legend('実験値', 'フィッテング')
end
