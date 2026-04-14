---
title: Chapter 1. Introduction
date: 2024-01-29
categories:
  - Bioinformatics
  - Algorithm
tags:
  - Concept Note
  - Introduction
  - Review
---

> "DNA 복제는 유전체의 어디서부터 시작되는가?"

## 개요

이 장에서는 유전체의 복제 과정이 시작되는 *ori* (Origin of Replication)을 간단한 예시를 통해 찾는 방법과 알고리즘을 학습한다.

이러한 단순한 경우로서 *ori* 를 찾기 위한 다음의 몇가지 단서들을 이용해 유전체에서 해당 조건을 만족하는 motif 서열(책에서는 pattern, k-mer)을 탐색하였다.

1. 유전체에서 얼마나 **자주** 등장하는가?
1. 자주 등장한다면, 그 pattern의 **reverse complement 등장 횟수**도 높은 빈도로 등장하는가?
1. 유전체의 **일정 영역에서 빈도수**가 높은가?(즉, 밀도있게 등장하는가?; localization)
1. G-C ratio(%)의 비율이 **비대칭적**인가?
1. **유사한 문자열**의 등장 빈도는 어떠한가?

## 서론

세포에서는 다양한 생물학적 과정을 수행하기 위해, 특정 서열이 반복적으로 나타난다.

### 생물학에서 단백질과 특이성(Specificity)

우리 몸에서 중요한 구성요소이며 다양한 역할을 수행하는 분자로, **단백질**이 있다. 단백질은 정확한 표적에 정확히 작용하기 위해 **특이성(specificity)** 이라는 특징을 가지는데, DNA의 예를 들면 특정 단백질에 대해 이와 특이적으로 결합하는 특정 DNA 서열을 가진다.

### DNA의 이중 나선 구조와 복제

한편, DNA의 복제(replication)는 생물의 가장 기본적인 구성 단위인 세포가 그 수를 늘리기 위해 필요한 과정인데, 이중 나선으로 이루어진 DNA를 복제하기 위해서는 이를 풀어내는 과정이 필수불가결하다.

특히, 이번 장에서는 원형의 유전체를 가지는 bacterial genome에 대한 복제를 기준으로 전체적인 흐름이 진행되는데, 원형의 유전체는 이중 나선의 끝과 끝이 닫힌 형태(closed form)이기 때문에 복제가 시작되는 영역이 어디에 위치해 있는지를 아는 것은 중요하며, 이 영역을 **origin of replication**(***ori***)이라 한다.

### DnaA box

앞서 설명한 바와 같이, 유전체는 복제가 시작되기 위해 이중 나선을 풀어주는 과정이 필요하다. 따라서, *ori*라는 영역에는 이중 나선을 풀어주는 단백질이 결합하는 DNA 영역이 존재한다. 이 과정에 관여하는 단백질과 DNA 서열 쌍을 DnaA protein - DnaA box(sequence)라 한다.

![DnaA box binding mechanism](dnaa-box-binding.png)
*Fig 1. DnaA box binding mechanism*

이러한 DnaA box - DnaA protein의 mechanism을 다음과 같이 간략히 정리할 수 있다.

- *ori* 에는 DnaA box와 AT-rich DNA element가 구성되어있음.

1. DnaA box에 DnaA protein이 결합함
1. DnaA box - DnaA protein의 결합이 AT-rich region을 unwinding (AT 결합은 2중 결합, 상대적으로 약함)
1. DnaC가 DnaB helicase에 결합함
1. DnaB-DnaC complex가 DNA에 결합되고 DnaC는 떨어져나감

→ 이중 가닥의 구조를 열어 polymerase의 결합을 유도함

### 마무리

정리하자면, 유전체 복제가 시작되는 영역을 찾기 위해서 DnaA box를 찾는 것은 중요하다.

하지만, 유전체에서 이러한 DnaA box를 생물학자들이 직접 실험을 통해 찾는 것은 경제적/시간적으로 큰 비용이 부담되기 때문에 몇가지 조건들을 통해 컴퓨터 과학자들이 이를 찾아내는 것이 효율적이다.

그러므로, 우리는 이번 장에서 DnaA box라는 암호를 찾는 방법에 대해서 논의해본다.
