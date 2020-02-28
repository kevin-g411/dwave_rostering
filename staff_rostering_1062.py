def callDwave(stamp):
    #量子（D-wave）を使用したシフトスケジューラ
    #シフト作成では
    #任意の人数の従業員を任意の日数で出勤日を確定します。
    
    
    #量子ビットチェック(未実装)
    
    #ライブラリの呼び出し
    from dwave.system.samplers import DWaveSampler
    from dwave.system.composites import EmbeddingComposite
    import pandas as pd
    import numpy as np
    import time
    import datetime
    import csv
    
    #パラメータ設定
    alpha = 0.1 #重み(スキル要求)
    beta = 15 #重み（希望出勤日）
    
    #条件読み込み
    dat = stamp
    with open(r"C:\Users\watanabe.kevin\Desktop\d-wave_output_oji\params\prm"+dat+".csv") as f:
        reader = csv.reader(f)
        f.closed
    
        l = [row for row in reader]
        l2 = [[] for i in range(4)]
        
    for i in range(4):
        count = 0
        while count < len(l[i]):
            if l[i][count] != '':
                l2[i].append(l[i][count])
            count += 1
    
    
    members = int(l2[0][0]) #登録従業員数
    duration = int(l2[0][1]) #シフト作成日数
    skills = int(l2[0][2]) #該当作業数
    elements = duration * members
    
    Skill = [float(s) for s in l2[1]] #各従業員の作業熟練度
    Will = [int(t) for t in l2[2]] #各従業員の出勤希望日
    Req_sd = [float(u) for u in l2[3]] #各営業日の作業ごとの必要従業員数
    

    #作業熟練度の規格化
    #全従業員で熟練度が合計1になるようにする
    #for i in range(members):
    #    sum = 0
    #    for j in range(skills):
    #        ind = i * skills + j
    #        sum = sum + Skill[ind]
    #    for j in range(skills):
    #        ind = i * skills + j
    #        Skill[ind] = Skill[ind] / sum


    #モデルの定義
    #QUBOモデル
    
    Q = dict()
    for d in range(duration):
       for n in range(members):
          for m in range(members):
              i = d * members + n
              j = d * members + m
              #対角成分
              if n == m:
                  work_force = 0
                  for s in range(skills):
                      t = n * skills + s
                      v = d * skills + s
                      work_force = work_force + (Skill[t] - 2 * Req_sd[v]) * Skill[t]
                  Q.update({("x"+str(i), "x"+str(j)):beta * Will[i] + alpha * work_force})
              #非対角成分
              elif n < m:
                  work_force = 0
                  for s in range(skills):
                      t = n * skills + s
                      u = m * skills + s
                      work_force = work_force + Skill[t] * Skill[u]
                  Q.update({("x"+str(i), "x"+str(j)):2 * alpha * work_force})
              else:
                  continue
    
    #print(Q)
    
    # D-waveへの接続
    owntoken = "DEV-a1fd90e8ee0819f69f5274b38edc6aedbc2d1837"
    dwaveSampler = DWaveSampler(token = owntoken, proxy = "https://172.24.1.34:3128")
    response = EmbeddingComposite(dwaveSampler).sample_qubo(Q, num_reads = 3000)

    #データ処理
    #ここではcsvで出力している
    df_result = pd.DataFrame()

    k = 0
    with open(r'C:\Users\watanabe.kevin\Desktop\d-wave_output_oji\Dwave' + dat + '.csv', 'w',newline='') as f:
        writer = csv.writer(f)
        for sample, energy, num_occurrences, chain_break_fraction in list(response.data()):
            #print(sample, "Energy: ", energy, "Occurrences: ", num_occurrences)
            df_tmp = pd.DataFrame(dict(sample), index=[k])
            df_tmp['Energy'] = -energy
            df_tmp['Occurrences'] = num_occurrences
            df_result = df_result.append(df_tmp)
            writer.writerow([sample, 'Energy: ', energy, 'Occurrences: ', num_occurrences])
            k+=1
