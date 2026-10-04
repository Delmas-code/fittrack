import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget{
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Analytics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 20),

              //   Weekly steps chart card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Weekly Steps',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Averaging 5,100 / day',
                        style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                      ),
                      const SizedBox(height: 24,),
                      SizedBox(
                        height: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children:
                            const [
                              _ChartBar(label: 'M', heightFactor: 0.6),
                              _ChartBar(label: 'T', heightFactor: 0.6),
                              _ChartBar(label: 'W', heightFactor: 0.6, isActive: true),
                              _ChartBar(label: 'T', heightFactor: 0.6),
                              _ChartBar(label: 'F', heightFactor: 0.6),
                              _ChartBar(label: 'S', heightFactor: 0.6),
                              _ChartBar(label: 'S', heightFactor: 0.6),
                            ]
                        ),
                      )
                    ],
                  ),
                ),
              //   Streak Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Current Streak',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF111827),
                            ),
                          ),
                          SizedBox(height: 2,),
                          Text(
                            "You're doing great!",
                            style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                          ),
                        ],
                      ),
                      const Text(
                        '12 🔥',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF10B981),
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

class _ChartBar extends StatelessWidget {
  final String label;
  final double heightFactor;
  final bool isActive;

  const _ChartBar({
    required this.label,
    required this.heightFactor,
    this.isActive = false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: FractionalTranslation(
            translation: Offset.zero,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: heightFactor,
                child: Container(
                  width: 20,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF2563EB)
                        : const Color(0xFFDBEAFE),
                    borderRadius: BorderRadius.circular(4)
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
          ),
        )
      ],
    );
  }
}