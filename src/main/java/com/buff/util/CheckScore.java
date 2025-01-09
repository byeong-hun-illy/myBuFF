package com.buff.util;

public class CheckScore {

    // 점수를 입력받아 등급을 반환하는 메소드
    public static String evaluateGrade(int score) {
        if (score >= 90) {
            return "A";
        } else if (score >= 80) {
            return "B";
        } else if (score >= 70) {
            return "C";
        } else if (score >= 60) {
            return "D";
        } else {
            return "F";
        }
    }
}
