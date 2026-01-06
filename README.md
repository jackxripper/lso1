# lso1 : simple web-stresser script
## Overview

The analyzed script abuses the legitimate `wrk` HTTP benchmarking utility to generate extremely high volumes of HTTP traffic.  
Although labeled as a performance‑testing tool, its behavior, configuration, and execution pattern clearly classify it as **malicious DDoS software**.

### Key Characteristics
- **Attack Type:** HTTP Flood (Layer 7 DDoS)  
- **Utility Misused:** `wrk`  
- **Execution Pattern:** Infinite loop with 60‑second bursts  
- **Peak Load:** 405,000 concurrent connections  
- **Memory Usage:** ~1.6 GB  
- **Termination:** Manual interrupt only  

---

## Code Architecture

### Attack Vector Classification
| Property | Value |
|---------|--------|
| Attack Type | HTTP Flood |
| Utility Misused | wrk |
| Pattern | Infinite loop |
| Termination | SIGINT only |

### Configuration Modes
| Mode | Threads | Connections | Intensity |
|------|---------|-------------|-----------|
| High‑End PC | 32 | 12,655 | Extreme |
| VPS | 10 | 10,000 | High |
| Custom | User-defined | User-defined | Variable |

---

## Mathematical Modeling

### Concurrent Requests


\[
R_{total} = threads \times connections
\]



- Mode 1: `32 × 12,655 = 405,000`  
- Mode 2: `10 × 10,000 = 100,000`

### Complexity
- **Time:** \( O(\infty) \) — non‑terminating loop  
- **Space:** \( O(t \times c) \) — thread × connection growth  
- **Memory Estimate:** ~1.6 GB  
- **Socket Demand:** Up to 405k connections (exceeds OS limits)  

---

##  Critical Code Behavior

### Infinite Loop Structure


while true; do
wrk -t"$threads" -c"$connections" -d60s --timeout 10s --latency "$url"
echo "Run finished. Restarting..."
done


### Malicious Indicators
- No exit condition  
- Excessive connection counts     

---

## Impact Analysis

### Target Resource Exhaustion
- TCP connection table overflow  
- Thread pool saturation  
- CPU overload from connection management  
- Memory exhaustion  
- Bandwidth congestion  

### Example Calculation
If server capacity = 50,000 connections:
\[
\text{Impact} = \frac{405,000}{50,000} \times 100\% = 810\%
\]

