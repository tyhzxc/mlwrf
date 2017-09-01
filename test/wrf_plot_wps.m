clear,clc

dbstop if error

filename = 'namelist.wps';

nml = wps_read_nml(filename);
[domains, proj] = wrf_wps_dom(nml);

figure
m_proj(proj.map_proj, 'lon', [90 140], 'lat', [15 45], 'rectbox', 'on');
m_gshhs_h('patch', [0.5, 0.5, 0.5]);
m_grid('xtick', 100:5:130, 'ytick', 20:5:40);
hold on
nds = size(domains, 2);
colors = rand(nds, 3);
%% 调整经纬度坐标对偏移系数
lol = 0.99; % 经度向下偏移量
lor = 0.99; % 经度向下偏移量
lad = 1.0;  % 纬度向下偏移量
dfs = 12;  % d01等模拟域标注字体大小
tfs = 10;  % 每一模拟域经纬度坐标对字体大小

for i = 1:nds
    m_plot(domains{1,i}(1,:), ...
        domains{1,i}(2,:), ...
        'color', colors(i,:), ...
        'linewidth', 0.5);
    m_text(1.005*domains{1,i}(1,2), ...
        .99*domains{1,i}(2,2), ...
        sprintf('d0%d',i), ...
        'color', colors(i,:), ...
        'fontsize', dfs);    
    if i == 1
        lau = 1.01;  % D01纬度向上偏移量
    else
        lau = 1.0;  % 其余模拟域纬度向上偏移量
    end
    
    if i == 1
    m_text(lol*domains{1,i}(1,1), ...
        lad*domains{1,i}(2,1), ...
        sprintf('(%.4f\n  %.4f)', domains{1,i}(1,1), domains{1,i}(2,1)), ...
        'color', 'k', ...
        'fontsize', tfs)
    m_text(lol*domains{1,i}(1,2), ...
        lau*domains{1,i}(2,2), ...
        sprintf('(%.4f\n  %.4f)', domains{1,i}(1,2), domains{1,i}(2,2)), ...
        'color', 'k', ...
        'fontsize', tfs)
    m_text(lor*domains{1,i}(1,3), ...
        lau*domains{1,i}(2,3), ...
        sprintf('(%.4f\n  %.4f)', domains{1,i}(1,3), domains{1,i}(2,3)), ...
        'color', 'k', ...
        'fontsize', tfs)
    m_text(lor*domains{1,i}(1,4), ...
        lad*domains{1,i}(2,4), ...
        sprintf('(%.4f\n  %.4f)', domains{1,i}(1,4), domains{1,i}(2,4)), ...
        'color', 'k', ...
        'fontsize', tfs)
    end
end

title('WPS Domain')
