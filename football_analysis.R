# 导入足球比赛数据
football <- read.csv("football_results_2016_2026.csv")

# 查看前六行数据
head(football)

# 查看数据结构
str(football)

# 查看数据有多少行和多少列
dim(football)
# 查看所有列名
names(football)

# 查看前六行数据
head(football)

# 查看每一列的数据类型
str(football)
# 检查每一列有多少个缺失值
colSums(is.na(football))

# 查看每个联赛有多少条比赛记录
table(football$league)

# 查看每个赛季有多少条比赛记录
table(football$season)
# 删除全场比分缺失的比赛
football_clean <- subset(
  football,
  !is.na(home_goals) & !is.na(away_goals)
)

# 判断每场比赛是否由主队获胜
football_clean$home_win <- football_clean$home_goals >
  football_clean$away_goals

# 按联赛计算主场获胜比例
home_win_by_league <- aggregate(
  home_win ~ league,
  data = football_clean,
  FUN = mean
)

# 转换成百分比
home_win_by_league$home_win_percentage <-
  round(home_win_by_league$home_win * 100, 2)

# 显示结果
home_win_by_league
# 按赛季和联赛计算主场获胜比例
home_win_by_season <- aggregate(
  home_win ~ season + league,
  data = football_clean,
  FUN = mean
)

# 转换为百分比
home_win_by_season$home_win_percentage <-
  round(home_win_by_season$home_win * 100, 2)

# 查看结果
head(home_win_by_season, 12)
# 加载绘图包
library(ggplot2)

# 绘制各联赛每个赛季的主场获胜比例
ggplot(
  home_win_by_season,
  aes(
    x = season,
    y = home_win_percentage,
    color = league,
    group = league
  )
) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  labs(
    title = "Home Win Percentage by League and Season",
    x = "Season",
    y = "Home Wins (%)",
    color = "League"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)
  )