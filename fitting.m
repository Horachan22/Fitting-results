%% main
function fitting()
    file_name = "RC回路のRの波形.CSV";
    circuit   = elements(9.8, 1480, 3.98, 4.72, 97.7);
    
    % データの読み取り
    time     = transpose(read_csv_data(file_name, 0, 1901, 0, 0));
    exp_data = transpose(read_csv_data(file_name, 0, 1901, 1, 1));

    % 最小二乗法による近似
    approximate_data(time, exp_data, circuit.f_RC_R);
end

%% csvデータの読み取りを行う関数(R1:開始行、R2:終了行、C1:開始列、C2:終了列)
function read_data = read_csv_data(file_name, R1, R2, C1, C2)
    read_data = csvread(file_name, R1, C1, [R1, C1, R2, C2]);
    return
end

%% 最小二乗法で近似を行う関数
function approximate_data(x_data, y_data, func)
    x0    = [x_data(1), y_data(1)];
    app_y = lsqcurvefit(func, x0, x_data, y_data);
    app_x = linspace(x_data(1), x_data(end), length(x_data));
    plot_graph(x_data, y_data, func, app_x, app_y);
end

%% グラフを描く関数
function plot_graph(x_data, y_data, func, app_x, app_y)
    plot(x_data, y_data, app_x, func(app_y, app_x))
    title("RC回路のRの波形");
    xlabel("時刻t");
    ylabel("電圧V_R");
    legend('実験値', 'フィッテング')
end
