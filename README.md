# SaaS Churn Risk Analysis

***Done by Sam Buwalda as part of his Portfolio Project, August 2025***



## Table of Contents

1. [Project Description](#project-description)
2. [Who Might Find This Valuable?](#who-might-find-this-valuable)
3. [Business Questions Overview](#business-questions-overview)
4. [Dataset Description and Download Links](#dataset-description)
5. [Dataset Cleaning](#dataset-cleaning)
6. [Tools and Technologies Used](#tools-and-technologies-used)
7. [Analytical Approaches](#analytical-approaches)
8. [Key Insights and Recommendations](#key-insights-and-recommendations)
10. [Reflection](#reflection)



## Project Description

I initiated this portfolio project to showcase proof of skill in SQL and Power BI. The core purpose of this project is to show to hiring managers, employers, or recruiters that I am capable of performing data analysis, create visualizations, and set up reports using the tools SQL and Power BI. 

This project aims to identify which types of customers are at higher risk of cancelling their subscription. Keeping existing customers is often more valuable than constantly finding new ones. When people leave, it can slow down or even reverse business growth, even if new users keep signing up.

Churn isn’t always predictable. However, customers who cancel often share certain features, such as short contract durations or specific support setups. These signals only become visible when churn rates are compared across different customer features.

The plan is to use a dataset that includes information about the features of customers, their services, and customer support. This would allow us to portray certain types of customers that often are at higher risk of cancelling. To reveal these high-risk customer features, we will analyze the data, using both SQL and Power BI, to find out which features are most associated with churn. 

The idea is to find out which customers are at high-risk of cancelling their subscription, so it helps teams to respond to the high-risk customer groups. This kind of approach is valuable for companies that rely on long-term customer relationships, especially in subscription models.



#### Who Might Find This Valuable?

**Hiring managers and recruiters** seeking a data analyst with practical experience and a business-oriented mindset.



## **Business Questions Overview**

In this project, I will answer five business questions regarding a SaaS customer churn dataset, from Kaggle. First, I'll visualize the churn rate of all the customer features in the dataset. This will give us a good overview of the biggest main drivers of churn. Next, we will look at a selection of features for each question based on what is being asked. All of the questions are fictional and created by me to simulate real-world business scenarios. 

##### Question 1: Which features across the entire dataset show the strongest association with churn?

* **Goal**: Identify, at a global level, which individual features have the largest differences in churn rates between their categories. This provides a complete “top drivers” view without separating features into predefined groups such as product, support, or behavioral.
* **Decision impact:** Gives stakeholders a data-driven shortlist of the most impactful customer characteristics related to churn, enabling more focused retention strategies across all domains.

##### Question 2: Which sticky customer segments have the highest churn rate?

* **Goal**: Identify which stable customer features, defined by demographic or structural characteristics that rarely change within a quarter, are most at risk of cancellation. This allows churn prevention efforts to focus on segments that are both high-risk and stable enough to target consistently.
* **Decision impact:** Highlights long-term at-risk customer groups where intervention strategies (onboarding, retention campaigns, tailored offers) can be stably applied.

##### Question 3: Which product features or forms of customer support are associated with a higher risk of cancellation?

* **Goal**: Gain insight into which services and forms of customer support occur more frequently among customers who cancel. This allows companies to make targeted improvements to their service offering or support structure.
* **Decision impact:** If certain support options or services are found to be strongly linked to churn, companies can take action. For example, by improving onboarding, making certain services mandatory, or resolving technical issues.

##### Question 4: Are there behavior patterns that predict churn before customers leave?

* **Goal**: Early detection of increased churn risk by using indirect behavioral indicators instead of actual interaction logs or time series.
* **Decision impact:** The results help in building churn profiles that can be directly applied in onboarding, retention campaigns, or proactive service. This allows teams to intervene earlier with customers who show behavior that's highly associated with churn.

##### Question 5: How many customers cancel within the first months, and how does this evolve during the first year?

* **Goal**: Measure how many customers terminate their contract in the early stage of their subscription, and extend this to a full month-by-month trend for the first 12 months. This reveals when in the customer lifecycle the most cancellations occur.
* **Decision impact:** Provides clear insight into the timing of churn. If cancellations cluster in the first months, targeted interventions (improved onboarding, early support, welcome campaigns) can be prioritized to reduce early-stage churn. 



## **Dataset Description**

The dataset includes 7043 rows (customers) and 19 different customer features. The dataset is downloaded from Kaggle. 

##### Content

Each row represents a customer, each column contains customer’s attributes described on the column Metadata.

**The data set includes information about:**

- Customers who left within the last month – the column is called Churn
- Services that each customer has signed up for – phone, multiple lines, internet, online security, online backup, device protection, tech support, and streaming TV and movies
- Customer account information – how long they’ve been a customer, contract, payment method, paperless billing, monthly charges, and total charges
- Demographic info about customers – gender, age range, and if they have partners and dependents



Link to dataset: https://www.kaggle.com/datasets/blastchar/telco-customer-churn



## Dataset Cleaning

1. **Check for and Remove Duplicates**
2. **Handle Missing / Null Values**
3. **Create a Clean Final Table**
   - Save the cleaned dataset into a new SQL table (e.g., `cleaned_churn_data`)
   - This becomes the base for your SQL analysis and Power BI report



## Tools and Technologies Used

* **PostgreSQL & pgAdmin 4**: for data cleaning and descriptive analysis.
* **Power BI & DAX**: for descriptive analysis, visualizations, and creating a analysis report.
* **Markdown**: for writing documentation regarding this project.



## Analytical Approaches

#### Question 1: 

- **Segmentation frame:** All variables in the dataset, both categorical (e.g., `contract`, `internetservice`, `paymentmethod`) and binned numeric features (e.g., `tenure_group`, `monthlycharges_group`, `totalcharges_group`).
- **Approach:** For each feature, calculate the churn rate for every category. Rank the features starting with the features highest associated with churn, and form a ultimate risk profile based on the highest-risk features. 
- **Reflection:** This method provides a single ranked list of features with the clearest churn signals, making it easy to prioritize further investigation or targeted interventions. However, results remain correlational and should be interpreted cautiously.

#### Question 2: 

- **Segmentation frame**:

  Only include sticky characteristics that meet two conditions:

  - **Demographic** or **structural** with high switching cost → hard or unlikely to change once set.
  - Unlikely to change **within a quarter** → stable enough to be meaningful for retention actions.

- **Selected characteristics**:

  The following sticky characteristics were included:

  - `gender` (demographic)
  - `seniorcitizen` (demographic)
  - `partner` (household setup)
  - `dependents` (household setup)
  - `tenure_group` (monotonic accumulation, only increases)
  - `contract` (rarely changed before renewal)
  - `paymentmethod` (structural choice, high friction to change)
  - `internetservice` (infrastructure setup, rarely switched mid-contract)

- **Approach:** For each of these variables, I calculate the churn rate per category. Then make a list of the variables that are highest associated with churn. And make a risk profile including all the features that are associated with a churn rate of 30+%. 

- **Reflection:** By restricting the analysis to sticky traits, we avoid segments defined by fluid preferences (e.g. paperless billing, add-on services) that can change quickly and weaken the reliability of segmentation. A disadvantage is that these remain correlations without a causal basis.

#### Question 3: 

- **Segmentation frame:** We analyze churn rates based on *functional service and support characteristics*. These are variables that indicate whether a customer uses a particular service or form of support.
- **Selected characteristics:**
  - `TechSupport`
  - `OnlineSecurity`
  - `OnlineBackup`
  - `DeviceProtection`
  - `StreamingTV`
  - `StreamingMovies`
  - `PhoneService`
  - `MultipleLines`
  - `InternetService`
  - `PaperlessBilling`
- **Approach:** For each of these variables, I calculate the churn rate per category. Then make a list of the variables that are highest associated with churn. And make a risk profile including all the features that are associated with a churn rate of 30+%. 
- **Reflection:** This analysis helps less with understanding *who* cancels (as in Question 1) and more with *why* customers might leave. Important: this remains correlational. We cannot determine whether the use (or absence) of a service is actually the cause of churn.

#### Question 4: 

- **Context:** The dataset contains only static customer characteristics. Still, some of these can plausibly say something about behavior, engagement, or friction. We use these characteristics as *behavioral proxies*.
- **Selected behavioral proxies:**
  - `tenure` – Proxy for loyalty or onboarding problems
  - `contract` – Level of commitment (short vs. long)
  - `paperlessbilling` – Digital preference, convenience
  - `paymentmethod` – Friction or degree of automation
  - `monthlycharges` – Perceived value vs. cost
  - `totalcharges` – Lifetime value and intensity of use
- **Approach:** First, we categorize the numerical proxies (such as tenure and charges) into logical behavior groups through binning. We then calculate the churn rate per category for each of the variables. Then I make a list of the variables that are highest associated with churn. And make a risk profile including all the features that are associated with a churn rate of 30+%. 
- **Reflection:** This approach makes it possible to analyze behavior *indirectly*. While less accurate than real behavioral logs, it still provides valuable signals for early risk detection. All insights remain correlational and should be interpreted with caution.

#### Question 5: 

- **Segmentation frame:** Only the first 12 months after a customer signs up are considered.
- **Selected characteristics:**
  - `tenure` (in months)
  - `churn` (Yes/No flag)
- **Approach:** Count the number of churned customers per month for months 1–12 of tenure. Present the results in a line chart to highlight cancellation peaks and trends. Also make a bar chart that showcases the churn rate (in percentages) for each month of tenure.
- **Reflection:** This analysis does not explain *why* customers cancel, but it pinpoints *when* churn is most likely to occur. 



## Key Insights and Recommendations

### Question 1: 

**Risk profile features ranked (40+% churn rate):**

- Tenure 0-12 months (47,44% churn rate)
- Electronic check (45,29% churn rate)
- Month to month contract (42,71% churn rate)
- Fiber optic internet service (41,89% churn rate)
- No online security (41,77% churn rate)
- Senior citizen (41,68% churn rate)
- No techsupport (41,64% churn rate)
- Total charges €0-€500 (41,45% churn rate)

**Insight:**

The analysis shows a ranked list of customer features with churn rates above 40%. On the right, we see the churn rate of the combined risk profile made from those features.

The results show that new customers (0–12 months of tenure) with month-to-month contracts are most likely to cancel. This makes sense, since many of them are still trying out the service to see if it meets their needs. Making a strong first impression with these customers should be the main priority.

Another important finding is that customers who pay by electronic check have the second-highest churn rate. Because they make a manual payment every month, they are more aware of the cost and more likely to ask themselves if the service is worth it. If the answer is no, they cancel. Customers on automatic payments think about this less often.

A possible action is to move more customers to automatic payment methods, which would reduce the monthly “reminder” effect and lower cancellations.

### Question 2: 

**Risk profile features ranked (30+% churn rate):**

- Tenure 0-12 Months (47,44% churn rate)
- Electronic check (45,29% churn rate)
- Month-to-month contract (42,71% churn rate)
- Fiber optic internet service (41,89% churn rate)
- Senior citizen (41,68% churn rate)
- No partner (32,96% churn rate)
- Independent (31,28% churn rate)

**Insight:**

These results focus on stable customer features that rarely change, such as demographics, household setup, internet service, and contract type. Because these features don’t shift often, they are reliable indicators for long-term churn risk.

Similar to Question 1, the data shows that new customers with month-to-month contracts should be the top priority for retention efforts. Customers paying by electronic check (manual monthly payment) also stand out again as a high-risk group.

Looking at demographics and household features, senior citizens have the highest churn rate of all (40%+), well above average. This makes older customers an important group to pay special attention to.

### Question 3: 

**Risk profile features ranked (30+% churn rate):**

- Fiber optic internet service (41,89% churn rate)
- No online security (41,77% churn rate)
- No tech support (41,64% churn rate)
- No online back-up (39,93% churn rate)
- No device protection (39,13% churn rate)
- No streaming movies (33,68% churn rate)
- Paperless billing (33,57% churn rate)
- No streaming TV (33,52% churn rate)

**Insight:**

The most striking result here is that customers with no extra services or add-ons are more likely to cancel than those who do have them. This suggests that churn is not mainly about being unhappy with add-on products or support.

Instead, it points to commitment and trust. Customers with only one service feel it’s easy to cancel. But those who use multiple services are more tied in — cancelling would mean moving everything to another provider, which takes more effort.

Takeaway: The more services customers use, the more committed and loyal they become. Encouraging them to adopt additional services can reduce churn.

### Question 4: 

**Risk profile features ranked (30+% churn rate):**

- 0-12 months tenure (47,44% churn rate)
- Electronic check (45,29% churn rate)
- Month-to-month contract (42,71% churn rate)
- €0-€500 total charges (41,45% churn rate)
- €75-€100 monthly charges (37,25% churn rate)
- Paperless billing (33,57% churn rate)

**Insight:**

All features are included in this risk profile. Compared to the profiles from segments and product & support, this one shows the highest churn rate. When compared to the overall churn rate, it confirms a strong link between churn and certain customer behaviors.

The categories most associated with churn reflect:

- Low commitment (0–12 months tenure, €0–500 total charges, month-to-month contract)
- High spending (€75–€100 monthly charges)
- Digital preferences (electronic check, paperless billing)

Actions to consider:

- Focus on building trust with new customers to increase commitment.
- Promote affordable customer packages, especially for new subscribers.

### Question 5: 

I created a line chart showcasing the trend of how many customers cancel their subscription each month, until the 12th month. 

As expected, most customers cancel at the start of their subscription, with the first month showing the highest churn. This highlights the importance of making a strong first impression. Key actions include:

- Meeting customer expectations
- Reducing early disappointments with the service
- Providing fast, helpful support
- Ensuring a smooth onboarding process
- Building trust from day one

After around the sixth month, churn levels off and becomes more stable.
