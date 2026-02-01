% 1. 加载辨识结果 (假设 main.m 运行后得到了 sol 和 drvGains)
load('UR10E_default.mat'); 

% 2. 构建全物理参数 (80+ 维度)
% 注意：这里需要你根据 base_params_qr.m 的逻辑，将 sol.x_estimated (Base) 
% 映射回 standard_params (Full)。
% 如果无法精确逆向，一个工程上的变通方法是：
% 创建一个全零向量，只填入你辨识出的组合参数对应的主要物理项，
% 或者使用 QR 分解时的映射矩阵 P 的逆（如果是满秩的）。
% 
% 但最简单且稳健的方法是：
% 如果你的 autogen 函数是由 standard_regressor 生成的，
% 那么你需要找到一种方法将 identified_params 变成 M/C/G 函数能接受的输入。
% *通常* M_mtrx_fcn 需要的是连杆的 [m, cx, cy, cz, Ixx, Iyy, Izz, Ixy, Ixz, Iyz] 等。

% 假设你已经构建好了 full_params (Nx1) 和 friction_params (12x1)
% 这里 full_params 必须严格对应 autogen 函数的输入顺序！
full_params = ...; % 你需要根据 baseQR 的结构填充这个向量
friction_params = ...; % [fv1...fv6, fc1...fc6]

% 3. 导出为 CSV 供 C++ 读取
writematrix(full_params, 'ur10e_inertial_params.csv');
writematrix(friction_params, 'ur10e_friction_params.csv');