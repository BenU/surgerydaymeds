# Surgery Day Medications

This project was started to help patients and the people who care for them have some evidence based guidance about their medications in the period leading up to a scheduled surgery.  

I've also put together a more userfriendly website at [www.surgerydaymeds.com](https://surgerydaymeds.com/) where medication lists can be entered and processed using the database generated here.  

If this project interests you and you have questions or want to help please reach out to me here through my github account.  

I'm using the [FDA's](http://www.fda.gov/default.htm) [National Drug Code Directory](http://www.fda.gov/Drugs/InformationOnDrugs/ucm142438.htm) Database file which can be downloaded [here](http://www.fda.gov/Drugs/InformationOnDrugs/ucm142438.htm).

If this project starts to be used by healthcare providers and their patients I will improve this project's documentation.

###Algorithm for which meds to take when:
*Note: I'll create a proper bibliography citing the evidence for these rules if this project ever gets legs and is being used.*
+ The default is to take a medication class as usual.
+ ACE-Inhibitors and ARB's: if taken in morning, skip that morning dose.
+ Diuretics: if taken in morning, skip that morning dose.
+ Beta-blockers, calcium channel blockers and alpha-2-agonists, if taken in the morning should be taken as usual.  Note: This rule is redundant with 'take as usual' but since we have good evidence that these meds should not be stopped I thought they should get a special rule.  Let me know your thoughts!
+ Oral Hypoglycemic Drugs except metformin: skip morning dose.
+ Metformin: Hold for at least 24 hours before major surgery.
+ Insulin: Discontinue long-acting forms and convert patient to regiment of NPH and regular.  Titrate day of surgery based on blood glucose level.
+ Blood thinners: Consult with surgeons and doctors who prescribed in the first place.  These medications often have compelling indications but contribute to surgical bleeding.  They may be discontinued or changed to a more short-acting for.  
+ NSAID's: This medication is an NSAID or non-steroidal anti-inflamatory drug.  They are taken for pain, to thin the blood or both.  When taken to thin the blood, they are often important to continue taking.  Still, because they can cause surgical bleeding, check with your doctors and surgeons.

*Copyright 2015 Benjamin D. Unger*

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
