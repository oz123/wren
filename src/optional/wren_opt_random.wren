foreign class Random {
  construct new() {
    seed_()
  }

  construct new(seed) {
    if (seed is Num) {
      seed_(seed)
    } else if (seed is Sequence) {
      if (seed.isEmpty) Fiber.abort("Sequence cannot be empty.")

      // TODO: Empty sequence.
      var seeds = []
      for (element in seed) {
        if (!(element is Num)) Fiber.abort("Sequence elements must all be numbers.")

        seeds.add(element)
        if (seeds.count == 16) break
      }

      // Cycle the values to fill in any missing slots.
      var i = 0
      while (seeds.count < 16) {
        seeds.add(seeds[i])
        i = i + 1
      }

      seed_(
          seeds[0], seeds[1], seeds[2], seeds[3],
          seeds[4], seeds[5], seeds[6], seeds[7],
          seeds[8], seeds[9], seeds[10], seeds[11],
          seeds[12], seeds[13], seeds[14], seeds[15])
    } else {
      Fiber.abort("Seed must be a number or a sequence of numbers.")
    }
  }

  foreign seed_()
  foreign seed_(seed)
  foreign seed_(n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16)

  foreign float()
  float(max) { float() * max }
  float(min, max) { float() * (max - min) + min }

  foreign int()
  int(max) { (float() * max).floor }
  int(min, max) { (float() * (max - min)).floor + min }
}